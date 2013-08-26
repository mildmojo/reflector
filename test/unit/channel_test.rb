require 'test_helper'

class ChannelTest < ActiveSupport::TestCase
  setup do
    @room = rooms(:jungle)
    @empty_room = rooms(:empty)
    @channel = channels(:client)

    verify @empty_room.channels.count == 1
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

  test 'should generate a from id on creation' do
    assert_not_nil Channel.create(room: @room).from_id
  end

  test 'should generate successive from ids on creation' do
    first = Channel.create(room: @empty_room)
    second = Channel.create(room: @empty_room)
    assert_equal 1, first.from_id
    assert_equal 2, second.from_id
  end

  test 'should not create channel without room' do
    assert_raises(ActiveRecord::RecordInvalid) do
      Channel.create!
    end
  end
end
