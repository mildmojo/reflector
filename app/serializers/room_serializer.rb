class RoomSerializer < ActiveModel::Serializer
  attributes :key, :friendly_name, :channel_key

  def channel_key
    object.created_by_channel.key
  end
end
