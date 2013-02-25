module Formitas
  class Field
    # Field with string as domain value
    class Fixnum < self
      DEFAULT_RENDERER = Renderer::Field::Input::Number

      # Return html value
      #
      # @return [String]
      #
      # @api private
      #
      def html_value(object)
        object.to_s
      end

    end
  end
end
