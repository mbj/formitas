module Formitas
  # Abstract context base class
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
      validator.call(resource).violations
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
      field(name).domain_value(resource)
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
      # @return [Enumerable<Violation>]
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

      # Return resource
      #
      # @return [Object]
      #
      # @api private
      #
      def resource
        doman_model.new(params)
      end
      memoize :resource
    end

    # Context initialized from domain object
    class Resource < self
      include Anima.new(*(anima.attribute_names + [:resource]))
    end
  end
end
