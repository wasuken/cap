require "socket"

class Api::V1::NetPacketsController < ApplicationController
  def index
    if User.where(token: params[:token]).size.zero?
      render json: {error: "failed token"}
    else
      ifaces_ips = Socket.getifaddrs.select{|x| x.name != "lo" && x.addr.ipv4?}
                     .map(&:addr)
                     .map(&:ip_address)
      @packets = NetPacket
                   .joins(:src)
                   .joins(:dst)
                   .select("srcs.*",
                           "dsts.*",
                           "net_packets.packet_type",
                           "net_packets.iface_name", "net_packets.id as npid")
                   .where.not(dsts: {dip: ifaces_ips})
      p ifaces_ips
      if params[:type]
        @packets = @packets.where(packet_type: params[:type])
      end
      if params[:iface]
        @packets = @packets.where(iface_name: params[:iface])
      end
      render json: @packets.order(npid: "desc").take(1000)
    end
  end
end
