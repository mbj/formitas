module Formitas

  class Renderer
    # Abstract base class that renders a context
    class Context < self

      delegate :name
      delegate :valid?
      delegate :domain_value
      delegate :html_value

      # Test if field is selected
      #
      # @return [true]
      #   if field is selected
      #
      # @return [false]
      #   otherwise
      #
      # @api private
      #  
      def selected?(name)
        object.selected?(name)
      end

      # Return html id
      #
      # @return [String]
      #
      # @api private
      #
      def html_id
        name.to_s
      end
      memoize :html_id

      # Return html name
      #
      # @param [Field] name
      #
      # @return [String]
      #
      # @api private
      #
      def html_name(field_name)
        "#{self.name}[#{field_name}]"
      end
    end
  end
end
