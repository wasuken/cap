require 'securerandom'
require 'socket'
class CaptureChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "packets"
  end
  def receive(data)
    # no certification for the time being.
    src = Src.find_or_create_by(data["src"])
    dst = Dst.find_or_create_by(data["dst"])
    host = Host.where(name: data["host"]).first ||
           Host.create(name: data["host"], htoken: SecureRandom.hex(35))
    NetPacket.create!(src_id: src.id, dst_id: dst.id, host_id: host.id,
                      content: data["content"], iface_name: data["iface_name"],
                      packet_type: data["type"])
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
