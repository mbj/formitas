module Formitas
  # An indexed set of fields
  class FieldSet
    include Adamantium::Flat, Enumerable

    # Initialize object
    #
    # @param [Enumerable<Field>]
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize(fields=[])
      @index = {}
      fields.each do |field|
        add(field)
      end
    end

    # Enumerate fields
    #
    # @return [self]
    #   if block given
    #
    # @return [Enumerator<Field>]
    #   otherwise
    #
    # @api private
    #
    def each(&block)
      return to_enum unless block_given?
      @index.values.each(&block)
      self
    end

    # Return field for name
    #
    # @param [Symbol] name
    #
    # @return [Field]
    #
    # @api private
    #
    def get(name)
      @index.fetch(name)
    end

  private

    # Add field to index
    #
    # @param [Field] field
    #
    # @return [undefined]
    #
    # @api private
    #
    def add(field)
      @index[field.name] = field
      self
    end
  end
end
