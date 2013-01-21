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

      def self.build(name=:submit, options={})
        super
      end
    end
  end
end
