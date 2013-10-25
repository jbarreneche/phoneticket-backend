json.(promotion, :id, :name, :discount_calculation_type, :discount_calculation_type, :validation_type)

json.set! "discount_calculation", promotion.discount_calculation
json.set! "validation", promotion.validation_strategy
