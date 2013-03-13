require 'test_helper'

class ChannelTest < ActiveSupport::TestCase
  setup do
    @channel = channels(:game)
  end

  test 'should create a channel' do
    assert_difference('Channel.count', 1) do
      Channel.create!
    end
  end

  test 'should generate a key on new' do
    assert_not_nil Channel.create.key
  end

  test 'should clean up old messages' do
    msg = messages(:aloha)
    Timecop.travel(5.minutes.from_now) do
      @channel.cleanup
    end

    assert_false Message.exists?(msg)
  end
end
