class Link < ActiveRecord::Base
  validates :full_link, :presence => true

  validates_uniqueness_of :youtube_link
  validates_uniqueness_of :full_link

end
