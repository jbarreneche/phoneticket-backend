class PriceSetting < ActiveRecord::Base
  DISCOUNT_DAYS = %w[mondays tuesdays wednesdays thursdays fridays saturdays sundays]
  serialize :discount_days, Array

  validates :adult, :kid, presence: true, numericality: { greater_than: 0 }
  validates :adult_with_discount, :kid_with_discount, presence: true, numericality: { greater_than: 0 },
    if: :has_a_discount_day?

  def discount_days=(discounts)
    super(discounts.reject(&:blank?))
  end

  def self.total_price_for(reservation)
    30
  end

  private

  def has_a_discount_day?
    !discount_days.size.zero?
  end

end
