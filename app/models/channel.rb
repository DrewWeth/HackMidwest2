class Channel < ActiveRecord::Base
  validates :url, :presence => true
  validates_uniqueness_of :url
end
