module Formitas

  # This hierarchy is stupid will replace it 
  # with task oriented inputs and configurable renderers soon.

  # Abstract base class for a form field 
  class Field
    include Anima, AbstractClass, Adamantium

    # Attribute with default renderer lookup
    class DefaultRenderer < Anima::Attribute
      DEFAULT = Anima::Default::Generator.new do |object|
        object.class.default_renderer
      end
    end

    attribute :name
    attribute :renderer, DefaultRenderer

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
      new(options.merge(:name => name))
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
      include AbstractClass

      attribute :collection

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
