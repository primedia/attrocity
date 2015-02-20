module Attrocity
  RSpec.describe 'Default value' do

    before(:context) do
      module Examples
        class DefaultValueExample
          include Attrocity.model
          attribute :foo, coercer: :string, default: 'bar'
        end
      end
    end

    it 'defaults to default value' do
      example = Examples::DefaultValueExample.new
      # puts example.attribute_set.attributes.collect(&:inspect)
      expect(example.foo).to eq('bar')
    end

  end
end
