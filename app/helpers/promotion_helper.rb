module PromotionHelper

  def discount_calculation_types_collection
    DiscountCalculation::DISCOUNT_CALCULATION_TYPES.map do |type|
      [human_discount_calculation_type(type), type]
    end
  end

  def human_discount_calculation_type(type)
    I18n.t("promotion.discount_calculations.#{type}")
  end

  def validation_types_collection
    ValidationStrategy::VALIDATION_TYPES.map do |type|
      [human_vaildation_type(type), type]
    end
  end

  def human_vaildation_type(type)
    I18n.t("promotion.validation_strategies.#{type}")
  end

end
