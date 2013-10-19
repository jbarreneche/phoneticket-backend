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

  end

end