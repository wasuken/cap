require 'securerandom'

class NetPacketsController < ApplicationController
  before_action :authenticate_user!
  def index
    if user_signed_in?
      @token = current_user.token
      render "index"
    else
      render "index"
    end
  end
end
