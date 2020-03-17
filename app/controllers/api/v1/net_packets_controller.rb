class Api::V1::NetPacketsController < ApplicationController
  def index
    @packets = NetPacket.joins(:src).joins(:dst).select("srcs.*", "dsts.*", "net_packets.iface_name", "net_packets.id as npid")
    render json: @packets.order(npid: "desc").take(1000)
  end
end
