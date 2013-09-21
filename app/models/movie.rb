class Movie < ActiveRecord::Base
  has_many :shows, dependent: :restrict_with_error

end
