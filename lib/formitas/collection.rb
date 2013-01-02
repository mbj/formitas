module Formitas
  # Abstract collection base class
  class Collection
    include AbstractType, Enumerable, Adamantium::Flat, Anima.new(:label_renderer)

    # Return default label renderer
    #
    # @return [Class:Renderer::Label]
    #
    # @api private
    #
    def self.default_label_renderer
      self::DEFAULT_LABEL_RENDERER
    end

    # Build collection with defaults
    #
    # @param [Hash] attributes
    #
    # @return [Collection]
    #
    # @api private
    #
    def self.build(attributes)
      new({ :label_renderer => default_label_renderer }.merge(attributes))
    end

    # Enumerate options
    #
    # @return [self]
    #   if block given
    #
    # @return [Enumerator<Formitas::Option>]
    #   otherwise
    #
    # @api private
    #
    abstract_method :each

    # Html value and domain value as string
    class String < self
      include Anima.new(*(anima.attribute_names + [:strings]))

      DEFAULT_LABEL_RENDERER = Renderer::Label::HTMLValue

      # Enumerate options
      #
      # @return [self]
      #   if block given
      #
      # @return [Enumerator<Formitas::Option>]
      #   otherwise
      #
      # @api private
      #
      def each
        return to_enum unless block_given?

        strings.each do |string|
          yield Formitas::Option.new(:html_value => string, :domain_value => string)
        end
      end
    end

    # Map html value to domain value
    class Mapper < self
      DEFAULT_LABEL_RENDERER = Renderer::Label::DomainValue
      include Anima.new(*(anima.attribute_names + [:mapping]))

      # Enumerate options
      #
      # @return [self]
      #   if block given
      #
      # @return [Enumerator<Formitas::Option>]
      #   otherwise
      #
      # @api private
      #
      def each
        return to_enum unless block_given?

        mapping.each do |html_value, domain_value|
          yield Option.new(:html_value => html_value, :domain_value => domain_value)
        end

        self
      end
    end
  end
end
