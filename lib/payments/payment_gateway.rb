module PaymentGateway
  CreditCard = Struct.new(:number, :verification_code, :owner_name)
  Charge     = Struct.new(:status, :transaction_id)

  extend self

  def charge(credit_card, amount)
    # Reject all nines credit card numbers
    if credit_card.number =~ /\A[9\s\-]+\z/
      Charge.new("rejected", nil)
    else
      Charge.new("accepted", generate_transaction_id)
    end
  end

  private

  def generate_transaction_id
    (1..10).map { rand(36).to_s(36) }.join
  end

end
