module Formitas

  # This hierarchy is stupid will replace it 
  # with task oriented inputs and configurable renderers soon.

  # Abstract base class for a form field 
  class Field
    include AbstractType, Adamantium::Flat, Anima.new(:name, :renderer)

    # Return binding for domain value
    #
    # @param [Object] domain_value
    #
    # @return [Binding::Domain]
    #
    # @api private
    #
    def bind(domain_value)
      Binding::Domain.new(self, domain_value)
    end

    # Return default renderer
    #
    # @return [Class:Renderer::Field]
    #
    # @api private
    #
    def self.default_renderer
      self::DEFAULT_RENDERER
    end

    # Return domain value for resource
    #
    # @param [Object] resource
    #
    # @return [Object]
    #
    # @api private
    #
    def domain_value(resource)
      resource.public_send(name)
    end

    # Build field with defaults
    #
    # @param [Symbol] name
    # @param [Hash] options
    #
    # @return [Field]
    #
    # @api private
    #
    def self.build(name, options = {})
      new({:renderer => default_renderer}.merge(options.merge(:name => name)))
    end
  end
end
