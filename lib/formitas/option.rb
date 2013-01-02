module Formitas
  # Selectable option (does not need to be a <select><option...)

  class Option
    include Adamantium::Flat, Anima.new(:html_value, :domain_value)
  end
end
