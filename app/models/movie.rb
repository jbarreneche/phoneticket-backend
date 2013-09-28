class Movie < ActiveRecord::Base
  has_many :shows, dependent: :restrict_with_error
  mount_uploader :cover, CoverUploader
  serialize :cast, Array

  GENRES = %w[action adventure animation biography comedy documentary
    drama family horror musical mystery romance sci-fi thriller]
  AUDIENCE_RATINGS = %w[ATP PG-13 PG-16 PG-18]

  validates_presence_of :title, :synopsis, :cast, :director, :cover

  validates :genre, inclusion: GENRES
  validates :audience_rating, inclusion: AUDIENCE_RATINGS

  validates_format_of :youtube_trailer,
    with:  %r{\Ahttp://www\.youtube\.com/watch\?v=([a-zA-Z0-9_-]*)\z},
    allow_blank: true
  validate :at_least_one_actor

  scope :join_active_shows, -> { joins(:shows).merge(Show.active) }
  scope :with_active_shows, -> { join_active_shows.group("movies.id").having("count(shows.id) > 0") }

  def cast_raw
    cast.join("\n") if cast?
  end

  def cast_raw=(values)
    self.cast = (values || "")
      .split("\n")
      .map {|name| name.strip.titlecase }
      .reject(&:empty?)
  end

  def active_shows
    shows.active
  end

  private

  def at_least_one_actor
    errors.add(:cast_raw, "Debe haber al menos un actor") unless cast.any?
  end

end
