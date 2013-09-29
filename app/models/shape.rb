class Shape
  CONFIGS = {
    "standard" => { # Seats count = 46
      "left" => {
        "rows" => %w[a b c d],
        "columns" => %w[1 2 3 4],
        "void_places" => [%w[a 1]]
      },
      "middle" => {
        "rows" => %w[a b c d],
        "columns" => %w[5 6 7 8],
        "void_places" => []
      },
      "right" => {
        "rows" => %w[a b c d],
        "columns" => %w[9 10 11 12],
        "void_places" => [%w[a 12]]
      }
    },
    "small" => { # Seats count = 10
      "left" => {
        "rows" => %w[a b],
        "columns" => %w[1 2],
        "void_places" => [%w[a 1]]
      },
      "middle" => {
        "rows" => %w[a b],
        "columns" => %w[3 4],
        "void_places" => []
      },
      "right" => {
        "rows" => %w[a b],
        "columns" => %w[5 6],
        "void_places" => [%w[a 6]]
      }
    }
  }

  attr_reader :name

  SHAPES_CACHE = {}
  def self.for_name(name)
    SHAPES_CACHE[name] ||= new(name, CONFIGS.fetch(name))
  end

  def initialize(name, config = {})
    @name = name
    @config = config
  end

  def bodies
    @bodies ||= @config.map do |body_name, config|
      Body.new(body_name, config)
    end
  end

  def places
    @places ||= bodies.collect_concat(&:places)
  end

  class Body
    attr_reader :rows, :columns, :void_places
    def initialize(name, config)
      @name = name

      @rows        = config.fetch("rows")
      @columns     = config.fetch("columns")
      @void_places = config.fetch("void_places")
    end

    def places
      @places ||= body_matrix - void_places
    end

    private

    def body_matrix
      rows.product(columns)
    end

  end

end
