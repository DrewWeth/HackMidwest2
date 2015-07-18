class TransProvided < ActiveRecord::Migration
  def change
    add_column :links, :transcript_provided, :boolean
  end
end
