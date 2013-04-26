class Room < ActiveRecord::Base
  has_many :channels
  belongs_to :created_by_channel, class_name: 'Channel'

  attr_accessible :created_by_channel, :friendly_name

  before_create :generate_key
  before_create :generate_friendly_name

  validates :created_by_channel, presence: true

  ##############################################################################
  private
  ##############################################################################

  def generate_key
    self.key = SecureRandom.uuid
  end

  def generate_friendly_name
    self.friendly_name =  Forgery(:basic).color + '-' +
                          Forgery(:currency).description.split(/ /).first + '-' +
                          Forgery(:address).city.split(/ /).first
  end
end
