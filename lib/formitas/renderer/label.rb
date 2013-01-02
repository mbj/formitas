module Formitas
  class Renderer

    # Abstract base class for label renderers
    class Label < self
      # Label renderer that returns html values
      class HTMLValue < self

        # Return label for object
        #
        # @param [Object] object
        #
        # @return [String]
        #
        # @api private
        #
        def self.render(object)
          object.html_value
        end

      end

      # Label renderer that returns domain values
      class DomainValue < self

        # Return label for object
        #
        # @return [Object] object
        #
        # @return [String]
        #
        # @api private
        #
        def self.render(object)
          object.domain_value.to_s
        end
      end

      # Label renderer that delegates to block
      class Block < self

        # Initialize object
        #
        # @return [undefined]
        #
        # @api private
        #
        def initialize(&block)
          @block = block
        end

        # Return label for object
        #
        # @param [Object] object
        #
        # @return [String]
        #
        # @api private
        #
        def render(object)
          @block.call(object)
        end

      end
    end
  end
end
