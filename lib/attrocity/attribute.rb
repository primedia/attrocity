module Attrocity
  class Attribute

    attr_reader :name, :coercer, :mapper, :default

    def initialize(name, coercer, mapping, default=nil)
      @name = name
      @coercer = coercer
      @default = default
      @mapper = mapping
    end

    def to_value_attribute(data)
      val = ValueExtractor.new(data, mapper: mapper, coercer: coercer).value
      ValueAttribute.new(name, val)
    end

  end
end

