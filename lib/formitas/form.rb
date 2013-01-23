module Formitas
  # A form context with action (root form)
  class Form 
    include Adamantium::Flat, Delegation.new(:context), 
            Anima.new(:action, :method, :enctype, :context)

    delegate :violations
    delegate :validator
    delegate :name
    delegate :fields
    delegate :binding

    # Return form renderer
    #
    # @return [Renderer::Form]
    #
    # @api private
    #
    def renderer
      Renderer::Context::Form.new(self)
    end
    memoize :renderer

    # Return form with domain object as input
    #
    # @param [Object] resource
    #
    # @return [Context]
    #
    # @api private
    #
    def with_resource(resource)
      util = self.class
      new_context = context.with_resource(resource)
      util.new(util.attributes_hash(self).merge(:context => new_context))
    end
  end
end
