module Formitas
  class Renderer
    # Abstract class for rendering a collection
    class Collection < self
      include AbstractType, Adamantium::Flat

      delegate :label_renderer

      # Return object label
      #
      # @param [Option] option
      #
      # @return [String]
      #
      # @api private
      # 
      def option_label(option)
        label_renderer.render(option)
      end

      # Render a collection with <option> tags
      class Options < self

        # Return html fragment
        #
        # @return [HTML::Fragment]
        #
        # @api private
        #
        def render
          HTML.join(options_html)
        end
        memoize :render

        # Test if option is selected for domain value
        #
        # @param [Object] domain_value
        #
        # @return [true]
        #   if domain value is selected
        #
        # @return [false]
        #   otherwise
        #
        # @api private
        #
        def selected?(domain_value)
          context.selected?(domain_value)
        end

      private

        # Return options html
        #
        # @return [Enumerable<HTML::Fragment>]
        #
        # @api private
        #
        def options_html
          object.map do |option|
            Renderer::Option.render(option, self)
          end
        end
      end
    end
  end
end
