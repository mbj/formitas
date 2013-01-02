module Formitas
  class Renderer
    class Field

      # Abstract class for <input> tag fields
      class Textarea < self

        # Return input html
        #
        # @return [HTML::Fragment]
        #
        # @api private
        #
        def input_html
          HTML.textarea(html_value, { 
            :id => html_id, 
            :name => html_name
          })
        end
        memoize :input_html

      end
    end
  end
end
