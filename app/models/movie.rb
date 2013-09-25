class Movie < ActiveRecord::Base
  has_many :shows, dependent: :restrict_with_error
  mount_uploader :cover, CoverUploader

  validates_presence_of :title

  validates_format_of :youtube_trailer,
    with:  %r{\Ahttp://www\.youtube\.com/watch\?v=([a-zA-Z0-9_-]*)\z},
    allow_blank: true

  scope :join_active_shows, -> { joins(:shows).merge(Show.active) }
  scope :with_active_shows, -> { join_active_shows.group("movies.id").having("count(shows.id) > 0") }

  def active_shows
    shows.active
  end

end
