class Channel < ActiveRecord::Base
  has_many :messages
  belongs_to :room

  before_create :generate_key
  after_create  :set_from_id

  validates :room, presence: true

  ##############################################################################
  private
  ##############################################################################

  def generate_key
    self.key = SecureRandom.uuid
  end

  # NOTE: This strategy will cause duplicate from_ids if a channel is deleted.
  #   So don't ever delete channels.
  def set_from_id
    self.from_id = Channel.where(room: room).order(:created_at).pluck(:key).index(key)
    save
  end
end
