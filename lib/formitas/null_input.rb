#encoding: utf-8
module Formitas
  class NullInput
    
    def self.valid?
      true
    end

    def self.input_hash
      {}
    end
  end
end