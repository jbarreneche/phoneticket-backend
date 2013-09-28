class Theatre < ActiveRecord::Base
  has_many :rooms, dependent: :restrict_with_exception
  has_many :shows, through: :rooms
  mount_uploader :photo, TheatrePhotoUploader

  def active_shows
    shows.active.includes(:movie, :room)
  end

  def to_s
    name
  end
end
