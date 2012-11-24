require 'adamantium'
require 'inflector'
require 'anima'
require 'rack'
require 'i18n'
require 'aequitas'
require 'delegation'

module Formitas

  Undefined = Object.new.freeze

  class Values
    include AbstractClass

    Empty = Class.new(self) do
      def get(name); nil; end
    end.new.freeze

    class Proxy
      def initialize(object)
        @object = object
      end

      def get(name)
        @object.public_send(name)
      end
    end
  end

  # Return translation
  #
  # I18n interface does not support :default on multi lookups so we do 
  # it externally
  #
  # @param [Array] lookups
  # @param [Hash] options
  #
  # @return [String]
  #   if translation could be found
  #
  # @return [Undefined] 
  #   otherwise
  #
  # @api private
  #
  def self.translate(lookups, options={})
    lookups.each do |lookup|
      result = I18n.translate(lookup, options.merge(:default => Undefined))
      return result unless result.equal?(Undefined)
    end

    Undefined
  end

  EmptyViolationSet = Class.new do
    include Adamantium::Flat
    def inspect; self.class.name; end
    def on(name); []; end
    def empty?; true; end
    def self.name; 'Formitas::EmptyViolationSet'; end
  end.new


  module Validator

    Valid = Class.new do
      include Adamantium::Flat
      def inspect; self.class.name; end
      def valid?; true; end
      def violations; EmptyViolationSet; end
      def self.name; 'Formitas::Validator::Valid'; end
    end.new
  end

end

require 'formitas/html'
require 'formitas/renderer'
require 'formitas/renderer/label'
require 'formitas/renderer/context'
require 'formitas/renderer/collection'
require 'formitas/renderer/context/form'
require 'formitas/renderer/option'
require 'formitas/renderer/field'
require 'formitas/renderer/field/input'
require 'formitas/renderer/field/select'
require 'formitas/renderer/field/textarea'
require 'formitas/renderer/violation'
require 'formitas/renderer/violation_set'

require 'formitas/form'
require 'formitas/field'
require 'formitas/field_set'
require 'formitas/binding'
require 'formitas/context'
require 'formitas/collection'
require 'formitas/option'
