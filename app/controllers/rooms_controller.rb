class RoomsController < ApplicationController
  def create
    # TODO: Do this a better way. Couldn't get build_created_by_channel to work.
    Room.transaction do
      begin
        room = Room.create!
        room.created_by_channel = Channel.create!(room: room)
        room.save!
        render json: room
      rescue ActiveRecord::RecordInvalid
        render json: { errors: room.errors.full_messages }
        raise ActiveRecord::Rollback
      end
    end
  end

  def join
    room = Room.where(friendly_name: params[:friendly_name]).first
    channel = Channel.create!(room: room)
    render json: channel
  end

end
