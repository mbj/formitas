module Formitas
  class Renderer
    class Field
      # Abstract base renderer for <select>
      class Select < self
        include AbstractType

        delegate :collection
        delegate :label_renderer

        # Return options label 
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

        # Render <select> with out multiple selections
        class Single < self

          # Return input html
          #
          # @return [HTML::Fragment]
          #
          # @api private
          #
          def input_html
            HTML.content_tag(:select, options_html, :id => html_id, :name => html_name)
          end

          # Test if input is selected
          #
          # @param [Object] domain_value
          #
          # @return [true]
          #   if input is selected for domain value
          #
          # @return [false]
          #   otherwise
          #
          def selected?(domain_value)
            binding.domain_value == domain_value
          end

          # Return options html
          #
          # @return [HTML::Fragment]
          #
          # @api private
          #
          def options_html
            Collection::Options.render(collection, self)
          end
        end
      end
    end
  end
end
