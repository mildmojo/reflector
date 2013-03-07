class Channel < ActiveRecord::Base
  has_many :messages

  before_create :generate_key

  attr_accessible :key, :name

  ##############################################################################
  private
  ##############################################################################

  def generate_key
    self.key = SecureRandom.uuid
  end
end
