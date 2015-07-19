class VideoDetails < ActiveRecord::Migration
  def change
    add_column :videos, :title, :string
    add_column :videos, :description, :text
    add_column :videos, :ups, :integer
    add_column :videos, :downs, :integer
    add_column :videos, :video_link, :string
  end
end
