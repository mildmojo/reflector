class Message < ActiveRecord::Base
  belongs_to :channel

  attr_accessible :body, :channel_id

  validates :channel, presence: true

  def self.for_channel key
    joins(:channel).where(channels: {key: key})
  end

  def self.since id
    where('messages.id > ?', id)
  end
end
