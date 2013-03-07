class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :key

      t.timestamps
    end

    add_index :channels, :key
  end
end
