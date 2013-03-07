class ChannelsController < ApplicationController
  def create
    channel = Channel.create!

    render json: channel
  end

  def show
    channel = Channel.where(key: params[:id]).first

    render json: channel
  end
end
