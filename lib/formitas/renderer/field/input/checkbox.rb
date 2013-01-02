module Formitas
  class Renderer
    class Field
      class Input

        # Abstract <input type="checkbox"> renderer
        class Checkbox < self
          include AbstractType

          TYPE = :checkbox

          # Return extra input attributes
          #
          # @return [Hash]
          #
          # @api private
          #
          def extra_input_attributes
            attributes = { :value => html_value }

            if selected?
              attributes[:checked]='checked'
            end

            attributes
          end

          # Return html value
          #
          # @return [String]
          #
          # @api private
          #
          abstract_method :html_value

          # Test if input is selected
          #
          # @return [true]
          #   if selected
          #
          # @return [false]
          #   otherwise
          #
          # @api private
          #
          abstract_method :selected?

          # Renderer for boolean checkbox
          class Boolean < self

            # Test if input is selected
            #
            # @return [true]
            #   if domain value is true
            #
            # @return [false]
            #   otherwise
            #
            # @api private
            #
            def selected?
              binding.domain_value.equal?(true)
            end
            memoize :selected?

            # Return html value
            #
            # @return [String]
            #
            # @api private
            #
            def html_value; '1'; end

            # Return hidden input
            #
            # @return [String]
            #
            # @api private
            #
            def hidden_html
              HTML.input(
                :type => :hidden,
                :name => html_name,
                :value => '0'
              )
            end

            # Return input html
            #
            # @return [String]
            #
            # @api private
            #
            def input_html
              HTML.join([hidden_html, super])
            end
            memoize :input_html

          end

        end
      end
    end
  end
end
