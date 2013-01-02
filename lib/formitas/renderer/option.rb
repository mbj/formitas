module Formitas
  class Renderer
    # Renderer for select <option>
    class Option < self

      delegate :label, :html_value, :domain_value

      # Test if option is selected
      #
      # @return [true]
      #   if option is selected
      #
      # @return [false]
      #   otherwise
      #
      # @api private
      #
      def selected?
        context.selected?(domain_value)
      end
      memoize :selected?

      # Return html fragment
      #
      # @return [HTML::Fragment]
      #
      # @api private
      #
      def render
        attributes = { :value => html_value }
        attributes[:selected] = :selected if selected?
        HTML.option(@context.option_label(self), attributes)
      end
      memoize :render

    end
  end
end
