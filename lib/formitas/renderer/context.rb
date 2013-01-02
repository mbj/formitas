module Formitas

  class Renderer
    # Abstract base class that renders a context
    class Context < self

      delegate :name
      delegate :binding
      delegate :violations

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

      # Test if context is valid
      #
      # @return [true] 
      #   if there are no violations
      #
      # @return [false]
      #  otherwise
      #
      # @api private
      #
      def valid?
        violations.empty?
      end

      # Return html name
      #
      # @param [Field] field_name
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
