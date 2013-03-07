require 'test_helper'

class ChannelsControllerTest < ActionController::TestCase
  test 'should create a channel' do
    assert_difference('Channel.count', 1) do
      post :create
    end
  end

  test 'should return only channel name and key' do
    post :create
    body = JSON.parse(@response.body)

    assert_equal %w(channel), body.keys
    assert_equal %w(key), body['channel'].keys
  end

  test 'should find channel by key' do
    get :show, id: channels(:game).key
    body = JSON.parse(@response.body)

    assert_equal channels(:game).key, body['channel']['key']
  end
end
