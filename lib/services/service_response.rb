module ServiceResponse

  class Entity < Struct.new(:entity)

    def successful?
      errors.empty?
    end

    def errors
      entity.errors
    end

  end

  class Success
    def successful?
      true
    end
  end

  class Error < Struct.new(:errors)

    def successful?
      false
    end

  end

  class Exception < Struct.new(:exception)

    def successful?
      false
    end

    def errors
      [exception.message]
    end

  end

end
