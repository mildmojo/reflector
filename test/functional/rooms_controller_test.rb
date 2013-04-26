require 'test_helper'

class RoomsControllerTest < ActionController::TestCase
  setup do
    @room = rooms(:jungle)
  end

  test 'should create room' do
    assert_difference('Room.count', 1) do
      post :create
    end
  end

  test 'should create channel on room creation' do
    assert_difference('Channel.count', 1) do
      post :create
    end
  end

  test 'should get room key on create' do
    post :create
    assert_not_empty json_body['room']['key']
  end

  test 'should get channel key on create' do
    post :create
    assert_not_empty json_body['room']['channel_key']
  end

  test 'should get friendly name on create' do
    post :create
    assert_not_empty json_body['room']['friendly_name']
  end

  test 'should join existing room by friendly name' do
    assert_no_difference('Room.count') do
      post :join, format: :json, friendly_name: @room.friendly_name
    end
  end

  test 'should create channel when joining room' do
    assert_difference('Channel.count', 1) do
      post :join, format: :json, friendly_name: @room.friendly_name
    end
  end

  test 'should get channel key when joining room' do
    post :join, format: :json, friendly_name: @room.friendly_name
    assert_not_empty json_body['channel']['key']
  end
end
