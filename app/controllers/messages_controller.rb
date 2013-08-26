class MessagesController < ApplicationController
  def index
    channel = Channel.where(key: params[:channel_id]).first
    messages = Message.for_channel(channel).to_a

    render json: messages
  end

  def since
    channel = Channel.where(key: params[:channel_id]).first
    messages = Message.for_channel(channel).
                       since(params[:last_seen_id]).
                       to_a

    render json: messages
  end

  def create
    channel = Channel.where(key: params[:channel_id]).first
    if channel
      Message.cleanup
      message = Message.new(params[:message])
      message.room = channel.room

      if message.save
        render json: message
      else
        render json: { errors: message.errors.full_messages }
      end
    else
      render json: { errors: "Channel not found: #{params[:channel_id]}" }
    end
  end
end
