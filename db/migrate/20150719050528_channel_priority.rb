class ChannelPriority < ActiveRecord::Migration
  def change
    add_column :channels, :priority, :integer, :default => 0
    add_column :links, :priority, :integer, :default => 0
  end
end
