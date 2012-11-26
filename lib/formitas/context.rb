module Formitas
  # Abstract context without values
  class Context
    include Adamantium::Flat, Anima, AbstractType

    attribute :name
    attribute :fields
    attribute :validator

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
      # @param [Symbol] name
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
        EmptyViolationSet
      end

      # Return context with resource
      #
      # @param [Resource] resource
      #
      # @api private
      #
      def with_resource(resource)
        Resource.new(attributes.merge(:resource => resource))
      end
    end
  
    # Context initialized from html params
    class HTML < self
      attribute :params
      attribute :domain_model
      private :domain_model

      def domain_object
        domain_model.new(params)
      end
      memoize :domain_object
    end

    # Context initialized from domain object
    class Resource < self
      attribute :resource
    end
  end
end
