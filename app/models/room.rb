class Room < ActiveRecord::Base
  belongs_to :theatre
  has_many :shows
  composed_of :room_shape, class_name: "Shape", constructor: :for_name, mapping: %w[shape name]
  validates_uniqueness_of :name, scope: :theatre_id
  validates_presence_of :theatre, :name, :shape

  def to_label
    "#{name} (#{theatre})"
  end

  def total_seats
    room_shape.places.count
  end

end
