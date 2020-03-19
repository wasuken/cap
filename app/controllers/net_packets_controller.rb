require 'securerandom'

class NetPacketsController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = current_user
    @user.token = SecureRandom.base64(35)
    @user.save
    @token = @user.token
    render "index"
  end
end
