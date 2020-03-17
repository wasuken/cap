# coding: utf-8
require "packetfu"

class PacketCaptureJob < ApplicationJob
  include PacketFu
  queue_as :default

  def perform(*args)
    # Do something later
    # get interface who have ipv4
    ifaces = Socket.getifaddrs.select{|x| x.name != "lo" && x.addr.ipv4?}

    threads = []
    ifaces.each do |i|
      threads << Thread.new{ get_capture(i.name)}
    end
    threads.each{|t| t.join}

  end
  def get_capture(iface)
    cap = Capture.new(:iface=>iface, :start=>true)
    cap.stream.each do |pkt|
      ActiveRecord::Base.transaction do
        begin
          # 今はTCPのみ
          if TCPPacket.can_parse?(pkt)
            tcp_packet = TCPPacket.parse(pkt)
            src_mac = EthHeader.str2mac(tcp_packet.eth_src).to_s
            dst_mac = EthHeader.str2mac(tcp_packet.eth_dst).to_s
            src_ip = IPHeader.octet_array(tcp_packet.ip_src).join('.')
            dst_ip = IPHeader.octet_array(tcp_packet.ip_dst).join('.')
            src_port = tcp_packet.tcp_src.to_s
            dst_port = tcp_packet.tcp_dst.to_s

            src = Src.find_or_create_by(sip: src_ip, sport: src_port, smac: src_mac)
            p src
            dst = Dst.find_or_create_by(dip: dst_ip, dport: dst_port, dmac: dst_mac)
            p dst
            NetPacket.create!(src_id: src.id, dst_id: dst.id, iface_name: iface, content: pkt.force_encoding("UTF-8"))
          end
        rescue => er
          p er
          raise ActiveRecord::Rollback
        end
      end

    end
  end
end
