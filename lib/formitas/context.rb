module Formitas
  # Abstract context without values
  class Context
    include Adamantium::Flat, AbstractType, Anima.new(:name, :fields, :validator)

    # Return binding for name
    #
    # @param [Symbol] name
    #
    # @return [Binding::Domain]
    #
    # @api private
    #
    def binding(name)
      field(name).bind(domain_value(name))
    end

    # Return field for name
    #
    # @param [Symbol] name
    #
    # @return [Field]
    #
    # @api private
    #
    def field(name)
      fields.get(name)
    end

    # Return violations
    #
    # @return [Enumerable<Violations>]
    #
    # @api private
    #
    def violations
      validator.new(resource).violations
    end
    memoize :violations

  private

    # Return domain value
    #
    # @param [Symbol] name
    #
    # @api private
    #
    def domain_value(name)
      resource.public_send(name)
    end
  end

  class Context
    # Context for empty forms
    class Empty  < self

      # Return binding for name
      #
      # @param [Symbol] field_name
      #
      # @return [Binding::Empty]
      #
      def binding(field_name)
        Binding::Empty.new(field(field_name))
      end

      # Return violations
      #
      # @return [Formtias::Validator::Valid]
      #
      # @api private
      #
      def violations
        Set.new
      end

      # Return context with resource
      #
      # @param [Resource] resource
      #
      # @return [Context::Resource]
      #
      # @api private
      #
      def with_resource(resource)
        Resource.new(self.class.attributes_hash(self).merge(:resource => resource))
      end
    end
  
    # Context initialized from html params
    class HTML < self
      include Anima.new(*(anima.attribute_names + [:params, :domain_model]))

      # Return domain object
      #
      # @return [Object]
      #
      # @api private
      #
      def domain_object
        domain_model.new(params)
      end
      memoize :domain_object
    end

    # Context initialized from domain object
    class Resource < self
      include Anima.new(*(anima.attribute_names + [:resource]))
    end
  end
end
