require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  setup do
    @channel = channels(:game)
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
end
