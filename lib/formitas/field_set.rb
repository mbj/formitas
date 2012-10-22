module Formitas
  class FieldSet
    include Adamantium, Enumerable

    def initialize(fields=[])
      @index = {}
      fields.each do |field|
        add(field)
      end
    end

    def each(&block)
      @index.values.each(&block)
    end

    def get(name)
      @index.fetch(name)
    end

  private

    def add(field)
      @index[field.name] = field
      self
    end
  end
end
