class Message < ActiveRecord::Base
  belongs_to :room
  belongs_to :channel

  validates :room, presence: true

  def self.for_channel channel
    where(room_id: channel.room_id).where('messages.channel_id != ?', channel.id)
  end

  def self.since id
    if id.respond_to?(:id)
      id = id.id
    end
    where('messages.id > ?', id)
  end

  def self.cleanup
    msg_lifetime = Rails.application.config.message_lifetime
    where('created_at < ?', msg_lifetime.ago).delete_all
  end
end
