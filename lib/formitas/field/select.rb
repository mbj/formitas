module Formitas
  class Field
    # Base class for domain value selections 
    class Select < self
      include AbstractType, Anima.new(*(anima.attribute_names + [:collection]))

      # Form field with that allows a single selection
      class Single < self
        DEFAULT_RENDERER = Renderer::Field::Select::Single
      end

      # Form field with that allows multiple selections
      class Multiple < self
        DEFAULT_RENDERER = Renderer::Field::Select::Single
      end

    end
  end
end
