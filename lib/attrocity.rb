require 'attrocity/version'
require 'attrocity/attribute'
require 'attrocity/attribute_set'
require 'attrocity/coercers/integer'

module Attrocity

  def self.included(base)
    base.send(:prepend, Initializer)
    base.send(:extend, ClassMethods)
  end

  attr_reader :raw_data, :attribute_set

  def attributes
    attribute_set.to_h
  end

  module Initializer
    def initialize(data={})
      @raw_data = data
      @attribute_set = self.class.attribute_set.deep_clone
      @attribute_set.set_values(@raw_data)
    end
  end

  module ClassMethods
    def attribute(name, coercer, options={})
      attribute_set << Attribute.new(name)
    end

    def attribute_set
      @attribute_set ||= AttributeSet.new
    end
  end

end
