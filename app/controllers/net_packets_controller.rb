require 'securerandom'

class NetPacketsController < ApplicationController
  def index
    @user = current_user
    @user.token = SecureRandom.hex(35)
    @user.save
    @token = current_user.token
    render "index"
  end
end
