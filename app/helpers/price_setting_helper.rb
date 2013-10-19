module PriceSettingHelper

  def discount_days_collection
    human_weekdays(PriceSetting::DISCOUNT_DAYS).zip(PriceSetting::DISCOUNT_DAYS)
  end

end
