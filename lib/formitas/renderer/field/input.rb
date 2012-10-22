module Formitas
  class Renderer
    class Field

      # Abstract class for <input> tag fields
      class Input < self

        def type
          self.class::TYPE
        end

        def input_html
          HTML.input(input_attributes)
        end
        memoize :input_html

        def default_input_attributes
          { 
            :id => html_id, 
            :type => type, 
            :name => html_name
          }
        end

        def input_attributes
          default_input_attributes.merge(extra_input_attributes)
        end

        def extra_input_attributes
          {}
        end

        # Renderer for <input type="text">
        class Text < self
          TYPE = :text

          def extra_input_attributes
            { :value => binding.html_value }
          end
        end

        # Abstract <input type="checkbox"> renderer
        class Checkbox < self
          include AbstractClass

          TYPE = :checkbox

          def checked_value
            selected?  ? 'checked' : ''
          end
          memoize :checked_value

          def extra_input_attributes
            attributes = { :value => html_value }

            if selected?
              attributes[:checked]='checked'
            end

            attributes
          end

          abstract_method :html_value

          abstract_method :selected?

          # Renderer for boolena checkbox
          class Boolean < self

            def selected?
              binding.domain_value.equal?(true)
            end
            memoize :selected?

            def html_value; '1'; end

            def hidden_html
              HTML.input(
                :type => :hidden,
                :name => html_name,
                :value => '0'
              )
            end

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
