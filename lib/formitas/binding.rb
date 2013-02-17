module Formitas

  # Abstract base class for field with value
  class Binding
    include Adamantium::Flat, AbstractType

    abstract_method :html_value
    abstract_method :domain_value

    # Return field 
    #
    # @return [Field]
    #
    # @api private
    #
    attr_reader :field

  private

    # Initialize object
    #
    # @param [Field] field
    #
    # @api private
    #
    def initialize(field)
      @field = field
    end
  end

  class Binding
    # Binding for empty field
    class Empty < self
      include Equalizer.new(:field)

      EMPTY_STRING = ''.freeze

      # Return html value
      #
      # @return [String]
      #
      # @api private
      #
      def html_value
        EMPTY_STRING
      end

      # Return domain value
      #
      # @return [:Undefined]
      #
      # @api private
      #
      def domain_value
        Undefined
      end

    end

    # Binding for field with html value
    class HTML < self
      include Equalizer.new(:field, :html_value)

      # Return domain value loaded from html
      #
      # @return [Object]
      #   if successful
      #
      # @return [Undefined]
      #   otherwise
      #
      # @api private
      #
      def domain_value
        field.domain_value(html_value)
      end
      memoize :domain_value

    private

      # Initialize object
      #
      # @param [Field] field
      # @param [String] html_value
      #
      # @api private
      #
      def initialize(field, html_value)
        super(field)
        @html_value = html_value
      end
    end

    # Class for field with domain value
    class Domain < self
      include Equalizer.new(:field, :domain_value)

      # Return html value dumped from domain value
      #
      # @return [String]
      #   if successful
      #
      # @return [Undefined]
      #   otherwise
      #
      # @api private
      #
      def html_value
        field.html_value(domain_value)
      end
      memoize :html_value

      # Return bound domain value
      #
      # @return [Object] 
      #
      # @api private
      #
      attr_reader :domain_value

    private

      # Initialize object
      #
      # @param [Field] field
      #
      # @param [Object] domain_value
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize(field, domain_value)
        super(field)
        @domain_value = domain_value
      end
    end
  end
end
