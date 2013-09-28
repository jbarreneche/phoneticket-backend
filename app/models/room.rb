class Room < ActiveRecord::Base
  belongs_to :theatre
  has_many :shows

  def to_label
    "#{name} (#{theatre})"
  end
end
