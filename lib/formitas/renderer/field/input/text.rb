module Formitas
  class Renderer
    class Field
      class Input 

        # Renderer for <input type="text">
        class Text < self
          TYPE = :text

          # Return extra input attributes
          #
          # @return [Hash]
          #
          # @api private
          #
          def extra_input_attributes
            { :value => binding.html_value }
          end
        end

      end
    end
  end
end
