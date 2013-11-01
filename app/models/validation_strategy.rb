class ValidationStrategy
  attr_reader :code, :bank

  VALIDATION_TYPES = %w[code bank]

  def self.from_array(type, code, bank)
    case type.presence
    when nil
      nil
    when "code"
      Code.new(code)
    when "bank"
      Bank.new(bank)
    else
      raise ArgumentError, "invalid type: #{type}"
    end
  end

  def each_missing_field
  end

  class Code < ValidationStrategy

    def initialize(code)
      @code = code
    end

    def name; "code"; end

    def to_s
      "Código: #@code"
    end

    def each_missing_field
      yield(:validation_code) unless code.present?
    end

    def validate(promotionable)
      unless promotionable.promotion_code == @code
        promotionable.errors.add(:promotion_code, :invalid)
      end
    end

  end

  class Bank < ValidationStrategy

    def initialize(bank)
      @bank = bank
    end

    def name; "bank"; end

    def to_s
      "Banco: #@bank"
    end

    def each_missing_field
      yield(:validation_bank) unless bank.present?
    end

    def validate(promotionable)
      if promotionable.card_number.starts_with? "9"
        promotionable.errors.add(:card_number, :invalid)
      end
    end
  end

end
