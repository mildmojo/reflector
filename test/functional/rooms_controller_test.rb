require 'test_helper'

class RoomsControllerTest < ActionController::TestCase
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

end
