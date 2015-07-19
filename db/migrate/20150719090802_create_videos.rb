class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.text :transcript
      t.text :compressed_text
      t.integer :channel_id
      t.integer :link_id
      t.integer :views
      t.string :thumbnail

      t.timestamps
    end
  end
end
