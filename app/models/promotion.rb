class Promotion < ActiveRecord::Base
  validates :name, :starts_on, :ends_on, :discount_calculation_type, :validation_type, presence: true
  validate :ends_in_future, on: :create
  validate :ends_after_starts
  validate :discount_calculation_configured
  validate :validation_configured
  validates :discount_n, :discount_x, :discount_percentage, numericality: { greater_than: 0 },
    allow_blank: true

  composed_of :discount_calculation, class_name: "DiscountCalculation",
    constructor: :from_array, mapping: [
      %w[discount_calculation_type name],
      %w[discount_n n], %w[discount_x x],
      %w[discount_percentage percentage]
    ]

  composed_of :validation_strategy, class_name: "ValidationStrategy",
    constructor: :from_array, mapping: [
      %w[validation_type name], %w[validation_code code], %w[validation_bank bank]
    ]

  private

  def ends_in_future
    return unless ends_on?

    errors.add(:ends_on, :in_future) if ends_on < Date.current
  end

  def ends_after_starts
    return unless starts_on? && ends_on?

    errors.add(:ends_on, :greater_than, count: starts_on) if starts_on >= ends_on
  end

  def discount_calculation_configured
    return unless discount_calculation

    discount_calculation.each_missing_field do |missing|
      errors.add(missing, :invalid)
    end
  end

  def validation_configured
    return unless validation_strategy

    validation_strategy.each_missing_field do |missing|
      errors.add(missing, :invalid)
    end
  end

end
