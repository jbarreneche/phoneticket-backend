class PriceSetting < ActiveRecord::Base
  DISCOUNT_DAYS = %w[mondays tuesdays wednesdays thursdays fridays saturdays sundays]
  serialize :discount_days, Array

  def discount_days=(discounts)
    super(discounts.reject(&:blank?))
  end
end
