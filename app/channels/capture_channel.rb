require 'securerandom'
require 'socket'
class CaptureChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "packets"
  end
  def receive(data)
    # no certification for the time being.
    data.each do |pkt|
      src = Src.find_or_create_by(pkt["src"])
      dst = Dst.find_or_create_by(pkt["dst"])
      host = Host.where(name: pkt["host"]).first ||
             Host.create(name: pkt["host"], htoken: SecureRandom.hex(35))
      NetPacket.create!(src_id: src.id, dst_id: dst.id, host_id: host.id,
                        content: pkt["content"], iface_name: pkt["iface_name"],
                        packet_type: pkt["type"])
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
