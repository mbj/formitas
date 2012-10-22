require 'abstract_class'
require 'equalizer'
require 'adamantium'

# A delegator library that only allows one delegator per class
#
# I do not need more than one delegation target per class, so I do not support more.
#
class Delegation < ::Module
  include Adamantium, AbstractClass, Equalizer.new(:target_name)

  attr_reader :target_name

  def initialize(target_name)
    @target_name = target_name
  end

  # Hook called when mixin is included
  #
  # @param [Class,Module] descendant
  #
  # @return [self]
  #
  # @api private
  #
  def included(descendant)
    super

    define_delegate_macro(descendant)
  end

private

  # Class to bind subject and target together
  class Definer
    include Adamantium, Equalizer.new(:scope, :target_name)

    attr_reader :scope
    attr_reader :target_name

    # Define names to delegate
    #
    # @param [Enumerable<Symbol>] names
    #
    # @return [self]
    #
    # @api private
    #
    def define(names)
      names.each do |name|
        define_delegator(name)
      end

      self
    end

  private

    # Define method with name to delegate
    #
    # @param [Symbol] method_name
    #
    # @return [undefined]
    #
    # @api private
    #
    def define_delegator(method_name)
      target_name = @target_name
      @scope.send(:define_method, method_name) do |*args|
        send(target_name).public_send(method_name, *args)
      end
    end

    # Initialize object
    #
    # @param [Class,Module] scope
    # @param [Symbol] target_name
    #
    # @api private
    #
    def initialize(scope, target_name)
      @scope, @target_name = scope, target_name
    end
  end

  # Define delegate macro 
  #
  # @param [Class,Module] scope
  #
  # @return [undefined]
  #
  # @api private
  #
  def define_delegate_macro(scope)
    definer = Definer.new(scope, target_name)

    scope.define_singleton_method(:delegate) do |*names|
      definer.define(names)
    end
  end
end
