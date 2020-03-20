require 'securerandom'

class NetPacketsController < ApplicationController
  before_action :authenticate_user!
  def index
    if user_signed_in?
      @user = current_user
      @user.token = SecureRandom.hex(35)
      @user.save
      @token = current_user.token
      render "index"
    else
      render "index"
    end
  end
end
