module Attrocity
  CoercionError = Class.new(StandardError)
end

require 'attrocity/version'
require 'attrocity/attribute'
require 'attrocity/value_attribute_methods_builder'
require 'attrocity/attribute_set'
require 'attrocity/attributes_hash'
require 'attrocity/model'
require 'attrocity/model_attribute'
require 'attrocity/model_attribute_set'
require 'attrocity/value_extractor'
require 'attrocity/attributes/value_attribute'
require 'attrocity/attributes/value_attribute_set'
require 'attrocity/builders/object_extension_builder'
require 'attrocity/builders/model_builder'
require 'attrocity/coercer_registry'
require 'attrocity/coercers/boolean'
require 'attrocity/coercers/integer'
require 'attrocity/coercers/string'
require 'attrocity/mappers/key_mapper'

module Attrocity

  def self.model
    ModelBuilder.new
  end

  def self.object_extension
    ObjectExtensionBuilder.new
  end

  def self.default_mapper(name, default_value)
    KeyMapper.new(name, default_value)
  end

  module ModuleMethods
    def attribute(name, coercer:, default: nil,
                  from: Attrocity.default_mapper(name, default))
      coercer = CoercerRegistry.instance_for(coercer)
      attribute_set << Attribute.new(name, coercer, mapper(from, default), default)
    end

    def model_attribute(name, model:)
      ModelAttribute.new(name, model).tap do |model_attr|
        model_attribute_set << model_attr
      end
    end

    def mapper(mapping, default)
      if mapping.respond_to?(:call)
        mapping
      else
        Attrocity.default_mapper(mapping, default)
      end
    end

    def attribute_set
      @attribute_set ||= AttributeSet.new
    end

    def model_attribute_set
      @model_attribute_set ||= ModelAttributeSet.new
    end
  end

end

Attrocity::CoercerRegistry.register do
  add :boolean, Attrocity::Coercers::Boolean
  add :integer, Attrocity::Coercers::Integer
  add :string, Attrocity::Coercers::String
end
