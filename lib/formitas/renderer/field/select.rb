module Formitas
  class Renderer
    class Field
      # Abstract base renderer for <select>
      class Select < self
        include AbstractClass

        delegate :collection
        delegate :label_renderer

        def option_label(option)
          label_renderer.render(option)
        end

        # Render <select> with out multiple selections
        class Single < self

          def input_html
            HTML.content_tag(:select, options_html, :id => html_id, :name => html_name)
          end

          def selected?(domain_value)
            self.domain_value == domain_value
          end

          def options_html
            Collection::Options.render(collection, self)
          end
        end
      end
    end
  end
end
