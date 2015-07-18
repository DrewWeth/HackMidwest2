class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :full_link
      t.string :youtube_link
      t.string :progress
      t.integer :seen_count, :default => 0
      t.integer :video_id
      t.integer :transcript_id

      t.timestamps
    end
  end
end
