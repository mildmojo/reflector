require 'test_helper'

class ChannelTest < ActiveSupport::TestCase
  test 'should create a channel' do
    assert_difference('Channel.count', 1) do
      Channel.create!
    end
  end

  test 'should generate a key on new' do
    assert_not_nil Channel.create.key
  end
end
