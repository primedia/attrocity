require 'support/examples'
require 'attrocity'

module Attrocity
  RSpec.describe "Mapping" do
    describe 'with symbol mapper' do
      before do
        # TODO: Move this class declaration to support/examples.rb
        module Examples
          class Listing
            include Attrocity
            attribute :id, coercer: :string, from: :listingid
          end
        end
      end

      let(:data) { { 'listingid' => '1234' } }
      let(:listing) { Examples::Listing.new(data) }

      it 'maps attribute data to attribute name' do
        pending
        expect(listing.id).to eq('1234')
      end

      it 'does not respond to mapped name' do
        expect { listing.listingid }.to raise_error(NoMethodError)
      end
    end

    describe 'without explicit mapper' do
      it 'maps attribute data to attribute name' do
        person = Examples::Person.new(age: 44)
        expect(person.age).to eq(44)
      end
    end
  end
end
