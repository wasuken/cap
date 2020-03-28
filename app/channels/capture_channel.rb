require 'securerandom'
require 'socket'
require 'json'
class CaptureChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "packets"
  end
  def receive(data)
    # no certification for the time being.
    JSON.parse(data["data"]).each do |pkt|
      PacketPostJob.perform_later(pkt)
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
