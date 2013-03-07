class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :channel_id
      t.binary  :body, limit: 1.megabyte

      t.timestamps
    end

    add_index :messages, :created_at
  end
end
