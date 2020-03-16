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
      File.open("log_#{iface}.txt", mode = "w") do |f|
        f.write("<<#{iface}>>      #{pkt}")
        tcp_packet = TCPPacket.parse(pkt)
        src_mac = tcp_packet.eth_src
        dst_mac = tcp_packet.eth_dst
        src_ip = tcp_packet.ip_src
        dst_ip = tcp_packet.ip_dst
        src_port = tcp_packet.tcp_src
        dst_port = tcp_packet.tcp_dst
        src = Src.find_or_create_by(ip: src_ip, port: src_port, mac: src_mac)
        dst = Dst.find_or_create_by(ip: dst_ip, port: dst_port, mac: dst_mac)
        Packet.create!(src_id: src.id, dst_id: dst.id, iface_name: iface, content: pkt)
      end
    end
  end
end
