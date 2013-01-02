module Formitas
  # Abstract collection base class
  class Collection
    include AbstractType, Enumerable, Adamantium::Flat, Anima.new(:label_renderer)

    def self.default_label_renderer
      self::DEFAULT_LABEL_RENDERER
    end

    def self.build(attributes)
      new({ :label_renderer => default_label_renderer }.merge(attributes))
    end

    abstract_method :each

    # Html value and domain value as string
    class String < self
      include Anima.new(*(anima.attribute_names + [:strings]))

      DEFAULT_LABEL_RENDERER = Renderer::Label::HTMLValue

      def each
        return to_enum unless block_given?

        strings.each do |string|
          yield Formitas::Option.new(:html_value => string, :domain_value => string)
        end
      end
    end

    # Mapp html value to domain value
    class Mapper < self
      DEFAULT_LABEL_RENDERER = Renderer::Label::DomainValue
      include Anima.new(*(anima.attribute_names + [:mapping]))

      def each
        return to_enum unless block_given?

        mapping.each do |html_value, domain_value|
          yield Option.new(:html_value => html_value, :domain_value => domain_value)
        end

        self
      end
    end
  end
end
