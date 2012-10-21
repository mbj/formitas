module Formitas

  # Context of a named form element with fields
  class Context
    include Anima, Adamantium

    attribute :name
    attribute :fields
    attribute :values
    attribute :validator

    def domain_value(name)
      values.get(name)
    end

    # Return html value of named field
    #
    # @param [Symbol] name
    #
    # @return [String]
    #   if value is present
    #
    # @return [nil]
    #   otherwise
    #
    def html_value(field_name)
      fields.get(field_name).html_value(domain_value(field_name))
    end

    # Return if field is selected
    #
    # @param [Symbol] name
    #
    # @return [true]
    #   if field is selected
    #
    # @return [false]
    #   otherwise
    #
    # @api privateo
    #
    def selected?(field_name)
      field(field_name).selected?(domain_value(field_name))
    end

    # Return if context is in a valid state
    #
    # @return [true]
    #   if valid
    #
    # @return [false]
    #   otherwise
    #
    # @api private
    #
    def valid?
      validator.valid?
    end

    # Return mutated context
    #
    # @api private
    #
    def update(attributes)
      self.class.new(self.attributes.merge(attributes))
    end

    # Return field by name
    #
    # @param [Symbol] field_name
    #
    # @return [Field]
    #
    # @api private
    #
    def field(field_name)
      fields.get(field_name)
    end

    # A form body without an action (nested form)
    class Body < self
    end

    # A form context with action (root form)
    class Form < self
      include Anima, Adamantium

      attribute :action
      attribute :method
      attribute :enctype

      # Return form renderer
      #
      # @return [Renderer::Form]
      #
      # @api private
      #
      def renderer
        Renderer::Context::Form.new(self)
      end
      memoize :renderer
    end
  end

end
