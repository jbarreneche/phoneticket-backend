class DiscountCalculation
  attr_reader :n, :x, :percentage

  DISCOUNT_CALCULATION_TYPES = %w[two_for_one n_for_x percentage]

  def self.from_array(type, n, x, percentage)
    case type.presence
    when nil
      nil
    when "two_for_one"
      TwoForOne.new
    when "n_for_x"
      NForX.new(n, x)
    when "percentage"
      Percentage.new(percentage)
    else
      raise ArgumentError, "invalid type: #{type}"
    end
  end

  def each_missing_field
  end

  class TwoForOne < DiscountCalculation
    def name; "two_for_one"; end

    def to_s
      "2 x 1"
    end
  end

  class NForX < DiscountCalculation
    def initialize(n, x)
      @n, @x = n, x
    end

    def name; "n_for_x"; end

    def to_s
      "#@n x $ #@x"
    end

    def each_missing_field
      yield(:discount_n) unless n.present?
      yield(:discount_x) unless x.present?
    end
  end

  class Percentage < DiscountCalculation
    def initialize(percentage)
      @percentage = percentage
    end

    def name; "percentage"; end

    def to_s
      "#@percentage% OFF"
    end

    def each_missing_field
      yield(:discount_percentage) unless percentage.present?
    end
  end

end
