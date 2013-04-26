require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  setup do
    @channel = channels(:client)
    @other_channel = channels(:other_client)
    @message = messages(:aloha)

    verify @other_channel.room_id == @channel.room_id
  end

  test 'should create message' do
    assert_difference('Message.count', 1) do
      post :create, format: :json, channel_id: @channel.key,
                                   message: { body: 'hi' }
    end
  end

  test 'should return created message' do
    msg = 'hi'
    post :create, format: :json, channel_id: @channel.key,
                                 message: { body: msg }
    assert_equal msg, json_body['message']['body']
  end

  test 'should not create message for invalid channel' do
    assert_no_difference('Message.count') do
      post :create, format: :json, channel_id: 'foo-de-bar',
                                   message: { body: 'hi' }
    end
  end

  test 'should return errors for invalid message' do
    post :create, format: :json, channel_id: 'foo-de-bar',
                                 message: { body: 'hi' }

    assert_includes json_body.keys, 'errors'
    assert json_body['errors'].length > 0
  end

  test 'should get message' do
    get :index, format: :json, channel_id: @other_channel.key
    message_bodies = json_body['messages'].map { |m| m['body'] }

    assert_includes message_bodies, @message.body
  end

  test 'should get messages since last message' do
    msgs = [ messages(:aloha), messages(:goodbye) ]
    verify msgs.all? { |m| m.channel == @channel }
    last_seen_id, new_id = msgs.map(&:id).sort

    get :since, format: :json, channel_id: @other_channel.key,
                               last_seen_id: last_seen_id
    message_ids = json_body['messages'].map { |m| m['id'] }

    assert_includes message_ids, new_id
    assert_not_include message_ids, last_seen_id
  end

  test 'should delete old messages' do
    Timecop.travel(Time.now + 5.minutes) do
      post :create, format: :json, channel_id: @other_channel.key,
                                   message: { body: 'new_message' }
    end

    get :index, format: :json, channel_id: @channel.key
    message_bodies = json_body['messages'].map { |m| m['body'] }

    assert_not_include message_bodies, @message.body
  end
end
