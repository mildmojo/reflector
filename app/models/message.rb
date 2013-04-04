class Message < ActiveRecord::Base
  belongs_to :channel

  attr_accessible :body

  validates :channel, presence: true

  def self.for_channel key
    joins(:channel).where(channels: {key: key})
  end

  def self.since id
    if id.respond_to?(:id)
      id = id.id
    end
    where('messages.id > ?', id)
  end
end
