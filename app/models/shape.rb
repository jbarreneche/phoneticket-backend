require 'set'

class Shape
  CONFIGS = {}

  attr_reader :name

  SHAPES_CACHE = {}
  def self.for_name(name)
    SHAPES_CACHE[name] ||= new(name, CONFIGS.fetch(name))
  end

  def initialize(name, config = {})
    @name = name
    @config = config
  end

  def each_body(&block)
    return enum_for(:each_body) unless block

    bodies.each(&block)
  end

  def bodies
    @bodies ||= @config.map do |body_name, config|
      Body.new(body_name, config)
    end
  end

  def has_place?(seat_code)
    bodies.any? do |body|
      body.has_place? seat_code
    end
  end

  def void_places
    @void_places ||= bodies.inject(Set.new) {|set, body| set + body.void_places }
  end

  def places
    @places ||= bodies.inject(Set.new) {|set, body| set + body.places }
  end

  class Body
    attr_reader :rows, :columns, :void_places, :name
    def initialize(name, config)
      @name = name

      @rows        = config.fetch("rows")
      @columns     = config.fetch("columns")
      @void_places = Set.new config.fetch("void_places").map do |(row, column)|
        seat_code(row, column)
      end
    end

    def places
      @places ||= body_matrix - void_places
    end

    def to_matrix
      body_matrix.each_slice(rows.size)
    end

    def has_place?(seat_code)
      places.include? seat_code
    end

    private

    def body_matrix
      @body_matrix ||= Set.new(rows.product(columns).map do |(row, column)|
        seat_code(row, column)
      end)
    end

    def seat_code(row, column)
      "#{row}-#{column}"
    end

  end

end
