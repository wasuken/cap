class PacketPostJob < ApplicationJob
  queue_as :default

  def perform(pkt)
    # Do something later
    src = Src.find_or_create_by(pkt["src"])
    dst = Dst.find_or_create_by(pkt["dst"])
    host = Host.where(name: pkt["host"]).first ||
           Host.create(name: pkt["host"], htoken: SecureRandom.hex(35))
    NetPacket.create!(src_id: src.id, dst_id: dst.id, host_id: host.id,
                      content: pkt["content"], iface_name: pkt["iface_name"],
                      packet_type: pkt["type"])
  end
end
