class Theatre < ActiveRecord::Base
  has_many :rooms, dependent: :restrict_with_exception

  def to_s
    name
  end
end
