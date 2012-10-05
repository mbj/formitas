#encoding: utf-8
module Formitas
  class Dumper
    # Method object for rendering HTML error content 
    class Error < self
      include WebHelpers, Immutable
      
      # Return dump
      #
      # @return [Hash]
      #   the dumped representation
      #
      # @api private
      #
      def dump 
        content_tag(
          :p,
          escape_html(error),
          attributes
        )
      end
      memoize :dump

    private

      # Initialize dumper
      # 
      # @param [Enumerable] errors
      # @param [String] base_id
      # 
      # @return [undefined]
      #
      # @api private
      #
      def initialize(error, base_id)
        @error, @base_id = error, base_id
      end

      # Return errors
      # 
      # @return [Enumerable]
      #
      # @api private
      #
      attr_reader :error

      # Return base id
      # 
      # @return [String]
      #
      # @api private
      #
      attr_reader :base_id
      
      # Return attributes for content tag
      # 
      # @return [Hash]
      #
      # @api private
      #
      def attributes
        {
          :class => :error,
          :id => html_id 
        }
      end
      memoize :attributes

      # Return error id
      #
      # @return [String]
      # 
      # @api private  
      #
      def html_id
        "#{base_id}_error_msg_#{name}"
      end
      memoize :html_id

      # Return error name
      #
      # @return [String]
      # 
      # @api private  
      #
      def name
        rule.violation_type
      end

      # Return Aequitas rule
      #
      # @return [Rule]
      # 
      # @api private  
      #
      def rule
        error.rule
      end
    end
  end
end
