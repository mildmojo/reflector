class RoomsController < ApplicationController
  def create
    # TODO: Do this a better way.
    Room.transaction do
      channel = Channel.create
      room = Room.new(created_by_channel: channel, friendly_name: params[:friendly_name])

      if room.save
        render json: room
      else
        render json: { errors: room.errors.full_messages }
        raise ActiveRecord::RollbackTransaction
      end
    end
  end
end
