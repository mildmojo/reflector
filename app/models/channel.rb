class Channel < ActiveRecord::Base
  has_many :messages
  belongs_to :room

  before_create :generate_key

  attr_accessible :key, :name

  def cleanup
    msg_lifetime = Rails.application.config.message_lifetime
    messages.where('created_at < ?', msg_lifetime.ago).delete_all
  end

  ##############################################################################
  private
  ##############################################################################

  def generate_key
    self.key = SecureRandom.uuid
  end
end
