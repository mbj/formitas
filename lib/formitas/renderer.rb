module Formitas

  # Abstract base class for renderers
  class Renderer
    include Adamantium, AbstractClass, Delegation.new(:object)

    # Render object
    #
    # @api private
    # 
    # @return [Object]
    #
    def self.render(*args)
      new(*args).render
    end

    # Return rendered object
    #
    # @return [Object]
    #
    # @api private
    #
    attr_reader :object
    private :object

    # Return rendering context
    #
    # @return [Object]
    #
    # @api private
    #
    attr_reader :context
    private :context

    abstract_method :render

    # Helper method that yields on error
    #
    # @yield 
    #   if form has error
    #
    # @return [self]
    #
    # @api private
    #
    def on_error
      yield unless valid?
      self
    end

    abstract_method :valid?

  private

    # Initialize object
    #
    # @param [Object] object
    # @param [Object] context
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize(object, context = Undefined)
      @object, @context = object, context
    end
  end
end
