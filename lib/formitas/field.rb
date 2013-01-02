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

    def self.default_renderer
      self::DEFAULT_RENDERER
    end

    def self.build(name, options = {})
      new({:renderer => default_renderer}.merge(options.merge(:name => name)))
    end

    # Abstract base class for <input> fields
    class String < self
      DEFAULT_RENDERER = Renderer::Field::Input::Text

      def html_value(object)
        object.to_s
      end
    end

    # Boolean field with true and false as domain values
    class Boolean < self
      include Equalizer.new(:renderer)

      DEFAULT_RENDERER = Renderer::Field::Input::Checkbox::Boolean
    end

    # Base class for value selections 
    class Select < self
      include AbstractType, Anima.new(*(anima.attribute_names + [:collection]))

      # Form field with that allows a single selection
      class Single < self
        DEFAULT_RENDERER = Renderer::Field::Select::Single
      end

      # Form field with that allows multiple selections
      class Multiple < self
        DEFAULT_RENDERER = Renderer::Field::Select::Single
      end
    end
  end
end
