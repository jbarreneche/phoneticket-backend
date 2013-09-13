class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_uniqueness_of :document

  def disable!
    update_attributes disabled: true
  end

  def enable!
    update_attributes disabled: false
  end

  def valid_for_authentication?
    !disabled? && super
  end

end
