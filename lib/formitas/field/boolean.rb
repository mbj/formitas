module Formitas
  class Field

    # Field with true and false as domain values
    class Boolean < self
      include Equalizer.new(:renderer)

      DEFAULT_RENDERER = Renderer::Field::Input::Checkbox::Boolean
    end

  end
end
