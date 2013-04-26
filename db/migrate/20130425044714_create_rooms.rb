class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :created_by_channel_id
      t.string  :key
      t.string  :friendly_name

      t.timestamps
    end

    add_column :channels, :room_id, :integer
  end
end
