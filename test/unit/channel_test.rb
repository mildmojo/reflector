require 'test_helper'

class ChannelTest < ActiveSupport::TestCase
  setup do
    @channel = channels(:client)
    @room = rooms(:jungle)

    verify @channel.room_id == @room.id, "#{@channel.room_id} should equal #{@room.id}"
  end

  test 'should create a channel' do
    assert_difference('Channel.count', 1) do
      Channel.create!(room: @room)
    end
  end

  test 'should generate a key on creation' do
    assert_not_nil Channel.create(room: @room).key
  end

  test 'should not create channel without room' do
    assert_raises(ActiveRecord::RecordInvalid) do
      Channel.create!
    end
  end
end
