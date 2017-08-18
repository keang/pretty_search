require "spec_helper"

RSpec.describe PrettySearch do
  it 'has a version number' do
    expect(PrettySearch::VERSION).not_to be nil
  end

  describe '#search' do
    let(:data) { './spec/fixtures/users.json' }
    context 'when there are matches' do
      let(:query) do
        PrettySearch::SimpleQuery.new({ 'suspended' => false })
      end

      it 'returns all matching objects' do
        found = PrettySearch.send(:search, query, data)
        expect(found.count).to eq 2
      end

      context 'when first:true' do
        it 'returns only 1 match' do
          found = PrettySearch.send(:search, query, data, first: true)
          expect(found.count).to eq 1
        end
      end
    end

    context 'when there are no matches' do
      let(:query) do
        PrettySearch::SimpleQuery.new({ 'suspended' => 123 })
      end

      it { expect(PrettySearch.send(:search, query, data)).to be_empty }
    end

    context 'when no data file is given' do
      let(:query) { PrettySearch::SimpleQuery.new({}) }
      it { expect{PrettySearch.run(query)}.to raise_error(PrettySearch::MissingParameter) }
    end
  end
end
