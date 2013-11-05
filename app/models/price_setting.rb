class PriceSetting < ActiveRecord::Base
  DISCOUNT_DAYS = %w[sundays mondays tuesdays wednesdays thursdays fridays saturdays]
  serialize :discount_days, Array

  validates :adult, :kid, presence: true, numericality: { greater_than: 0 }
  validates :adult_with_discount, :kid_with_discount, presence: true, numericality: { greater_than: 0 },
    if: :has_a_discount_day?

  def self.total_price_for(reservation)
    30
  end

  def discount_days=(discounts)
    super(discounts.reject(&:blank?))
  end

  def prices_for(date)
    {
      adult: adult_price_on(date.wday),
      kid:   kid_price_on(date.wday)
    }
  end

  private

  def adult_price_on(weekday)
    if has_discount_on? weekday
      adult_with_discount
    else
      adult
    end
  end

  def kid_price_on(weekday)
    if has_discount_on? weekday
      kid_with_discount
    else
      kid
    end
  end

  def has_discount_on?(weekday)
    discount_days.include? DISCOUNT_DAYS[weekday]
  end

  def has_a_discount_day?
    !discount_days.size.zero?
  end

end
