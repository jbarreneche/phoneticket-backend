class PromotionForm
  constructor: (@$form) ->
    @$discountType = @$form.find("[name='promotion[discount_calculation_type]']")
    @$discountN    = @$form.find("#promotion_discount_n_input")
    @$discountX    = @$form.find("#promotion_discount_x_input")
    @$percentage   = @$form.find("#promotion_discount_percentage_input")
    @refreshDiscountFields()
    @$discountType.change @refreshDiscountFields

    @$validationType = @$form.find("[name='promotion[validation_type]']")
    @$validationBank = @$form.find("#promotion_validation_bank_input")
    @$validationCode = @$form.find("#promotion_validation_code_input")
    @refreshValidationFields()
    @$validationType.change @refreshValidationFields

  refreshDiscountFields: =>
    switch @$discountType.val()
      when "n_for_x"
        @$discountN.show()
        @$discountX.show()
        @$percentage.hide()
      when "percentage"
        @$discountN.hide()
        @$discountX.hide()
        @$percentage.show()
      else
        @$discountN.hide()
        @$discountX.hide()
        @$percentage.hide()

  refreshValidationFields: =>
    switch @$validationType.val()
      when "bank"
        @$validationBank.show()
        @$validationCode.hide()
      when "code"
        @$validationBank.hide()
        @$validationCode.show()
      else
        @$validationBank.hide()
        @$validationCode.hide()

$ ->
  $('form.promotion').each ->
    new PromotionForm($(this))
