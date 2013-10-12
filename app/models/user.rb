class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_uniqueness_of :document, allow_nil: true

  has_many :purchases
  has_many :reservations

  def unfinished_reservations
    purchases.still_not_finished.includes(:seats, show: [:room, :movie])
  end

  def unfinished_purchases
    reservations.still_not_finished.includes(:seats, show: [:room, :movie])
  end

  def disable!
    update_attributes disabled: true
  end

  def enable!
    update_attributes disabled: false
  end

  def active_for_authentication?
    !disabled? && super
  end

  def inactive_message
    disabled? ? :disabled : super
  end

end
