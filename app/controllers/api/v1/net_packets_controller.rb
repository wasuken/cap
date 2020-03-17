class Api::V1::NetPacketsController < ApplicationController
  def index
    @packets = NetPacket.joins(:src).joins(:dst).select("srcs.*", "dsts.*", "net_packets.iface_name")
    render json: @packets
  end
end
