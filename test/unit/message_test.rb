require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  setup do
    @channel = channels(:client)
    @room    = rooms(:jungle)
    @message = messages(:aloha)

    verify @channel.room_id == @room.id
  end

  test 'should create message' do
    assert_difference('Message.count', 1) do
      msg = Message.new(channel: @channel, room: @room)
      msg.channel = @channel
      msg.save!
    end
  end

  test 'should not create message without channel' do
    assert_raises(ActiveRecord::RecordInvalid) do
      Message.create!
    end
  end

  test 'should limit messages by channel with for_channel' do
    channel = Channel.new(room: @room)
    assert_not_include Message.for_channel(channel).all, @message
  end

  test 'should limit messages by id with since' do
    verify Message.count > 1
    first_message = Message.first
    assert_not_include Message.since(first_message), first_message
  end

  test 'should clean up old messages' do
    msg = messages(:aloha)
    Timecop.travel(5.minutes.from_now) do
      Message.cleanup
    end

    assert_false Message.exists?(msg)
  end
end
