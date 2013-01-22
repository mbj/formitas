module Formitas
  class Renderer
    class Field

      # Abstract class for <input> tag fields
      class Submit < self

        # Return input html
        #
        # @return [HTML::Fragment]
        #
        # @api private
        #
        def input_html
          HTML.input( 
            :id => html_id, 
            :type => :submit,
            :value => label_text,
            :name => html_name
          )
        end
        memoize :input_html

      end
    end
  end
end
