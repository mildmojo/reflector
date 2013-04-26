require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  setup do
    @channel = channels(:client)
  end

  # test 'should require a created_by_channel' do
  #   room = Room.new
  #   assert_raises(ActiveRecord::RecordInvalid) do
  #     room.save!
  #   end
  # end

  test 'should generate a key on creation' do
    room = Room.create(created_by_channel: @channel)
    assert_not_nil room.key
  end

  test 'should generate a friendly name on creation' do
    room = Room.create(created_by_channel: @channel)
    assert_not_nil room.friendly_name
  end
end
