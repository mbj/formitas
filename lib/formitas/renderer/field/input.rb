module Formitas
  class Renderer
    class Field

      # Abstract class for <input> tag fields
      class Input < self

        # Return type string
        #
        # @return [String]
        # 
        # @api private
        #
        def type
          self.class::TYPE
        end

        # Return input html
        #
        # @return [HTML]
        #
        # @api private
        #
        def input_html
          HTML.input(input_attributes)
        end
        memoize :input_html

        # Return default input attributes
        #
        # @return [Hash]
        #
        # @api private
        # 
        def default_input_attributes
          { 
            :id => html_id, 
            :type => type, 
            :name => html_name
          }
        end

        # Return input attributes
        #
        # @return [Hash]
        #
        # @api private
        #
        def input_attributes
          default_input_attributes.merge(extra_input_attributes)
        end

        # Return extra input attributes
        #
        # @return [Hash]
        #
        # @api private
        #
        def extra_input_attributes
          {}
        end

      end
    end
  end
end
