class MessagesController < ApplicationController
  def index
    messages = Message.for_channel(params[:channel_id]).all

    render json: messages
  end

  def since
    messages = Message.for_channel(params[:channel_id]).
                       since(params[:last_seen_id]).
                       all

    render json: messages
  end

  def create
    channel = Channel.where(key: params[:channel_id]).first
    if channel
      channel.cleanup
      message = Message.new(params[:message])
      message.channel = channel

      if message.save
        render json: message
      else
        render json: { errors: message.errors.messages }
      end
    else
      render json: { errors: "Channel not found: #{params[:channel_id]}" }
    end
  end
end
