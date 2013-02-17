module Formitas
  class Field
    class Submit < self

      DEFAULT_RENDERER = Renderer::Field::Submit

      # Return domain value for resource
      #
      # @param [Object] resource
      #
      # @return [Object]
      #
      # @api private
      #
      def domain_value(resource)
        name
      end

      # Return html value for resource
      #
      # @param [Object] resource
      #
      # @return [Object]
      #
      # @api private
      #
      def html_value(resource)
        :submit
      end

      # Build  submit field
      #
      # @param [Symbol] name
      # @param [Hash] options
      #
      # @return [Field::Submit]
      #
      # @api private
      #
      def self.build(name=:submit, options={})
        super
      end
    end
  end
end
