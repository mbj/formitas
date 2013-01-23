module Formitas

  # Form input values
  class Values
    include AbstractType

    # Initialize object
    #
    # @param [Object] object
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize(object)
      @object = object
    end

    # Return value for field name
    #
    # @return [Symbol] name
    #
    # @return [Object]
    #
    # @api private
    #
    abstract_method :get

    # Proxy names to method class
    class Proxy < self

      # Initialize object
      #
      # @param [Object] object
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize(object)
        @object = object
      end

      # Return attribute value
      #
      # @param [Symbol] name
      #
      # @return [Object]
      #
      # @api private
      #
      def get(name)
        @object.public_send(name)
      end

    end

    # Access hash keys
    class Hash < self

      # Return attribute value
      #
      # @param [Symbol] name
      #
      # @return [Object]
      #
      # @api private
      #
      def get(name)
        @object[name.to_s]
      end

    end

    Empty = Hash.new({}) 
  end
end
