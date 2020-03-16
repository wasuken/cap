require "packetfu"
include PacketFu

def get_capture(iface)
  cap = Capture.new(:iface=>iface, :start=>true)
  cap.stream.each do |pkt|
    File.open("log_#{iface}.txt", mode = "w"){|f|
      f.write("<<#{iface}>>      #{pkt}")
      tcp_packet = TCPPacket.parse(pkt)
      src_mac = EthHeader.str2mac(tcp_packet.eth_src)
      dst_mac = EthHeader.str2mac(tcp_packet.eth_dst)
      src_ip = IPHeader.octet_array(tcp_packet.ip_src).join('.')
      dst_ip = IPHeader.octet_array(tcp_packet.ip_dst).join('.')
      src_port = tcp_packet.tcp_src
      dst_port = tcp_packet.tcp_dst
    }
  end
end

# get interface who have ipv4
ifaces = Socket.getifaddrs.select{|x| x.name != "lo" && x.addr.ipv4?}

threads = []
ifaces.each do |i|
  threads << Thread.new{ get_capture(i.name)}
end
threads.each{|t| t.join}
