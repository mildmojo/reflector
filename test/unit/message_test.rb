require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  setup do
    @channel = channels(:game)
    @message = messages(:aloha)
  end

  test 'should create message' do
    assert_difference('Message.count', 1) do
      msg = Message.new
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
    assert_not_include Message.for_channel('does_not_exist').all, @message
  end

  test 'should limit messages by id with since' do
    verify Message.count > 1
    first_message = Message.first
    assert_not_include Message.since(first_message), first_message
  end
end
