module Formitas
  class Renderer
    # Renderer for a set of violations
    class ViolationSet < self

      # Test if no violations are present
      #
      # @return [true]
      #   if no violations are present
      #
      # @return [false]
      #   otherwise
      #
      # @api private
      #
      def empty?
        !violations.empty?
      end

      # Return violation renderers
      #
      # @return [Enumerable<Renderer::Violation>]
      #
      # @api private
      #
      def violations
        object.map do |violation|
          Violation.new(violation, context)
        end
      end
      memoize :violations

      # Return html fragment
      #
      # @return [HTML::Fragment]
      #
      # @api private
      #
      def render
        if violations.empty?
          HTML::Fragment.new('')
        else
          HTML.content_tag(:div, inner_html, :class => :'error-messages')
        end
      end
      memoize :render

    private

      # Return list items html
      #
      # @return [HTML::Fragment]
      #
      # @api private
      #
      def list_items_html
        contents = violations.map { |violation| violation.render }
        HTML.join(contents)
      end

      # Return inner html
      #
      # @return [HTML::Fragment]
      #
      # @api private
      #
      def inner_html
        HTML.content_tag(:ul, list_items_html)
      end
      memoize :inner_html
    end
  end
end
