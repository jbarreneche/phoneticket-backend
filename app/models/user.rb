class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_uniqueness_of :document, allow_blank: true

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
