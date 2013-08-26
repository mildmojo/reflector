class Channel < ActiveRecord::Base
  has_many :messages
  belongs_to :room

  before_create :generate_key

  validates :room, presence: true

  ##############################################################################
  private
  ##############################################################################

  def generate_key
    self.key = SecureRandom.uuid
  end
end
