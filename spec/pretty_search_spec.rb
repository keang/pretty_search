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
        pretty_result = PrettySearch.run(query, data: data)
        expected_result = File.read('spec/fixtures/results/2_matches.txt')
        expect(pretty_result).to eq expected_result.chop
      end

      context 'when first:true' do
        it 'returns only 1 match' do
          pretty_result = PrettySearch.run(query, data: data, first: true)
          expected_result = File.read('spec/fixtures/results/1_match.txt')
          expect(pretty_result).to eq expected_result.chop
        end
      end
    end

    context 'when there are no matches' do
      let(:query) do
        PrettySearch::SimpleQuery.new({ 'suspended' => 123 })
      end

      it { expect(PrettySearch.run(query, data: data)).to eq 'No records found.' }
      it { expect(PrettySearch.run(query, data: data, first: true)).to eq 'No records found.' }
    end

    context 'when no data file is given' do
      let(:query) { PrettySearch::SimpleQuery.new({}) }
      it { expect{PrettySearch.run(query)}.to raise_error(PrettySearch::MissingParameter) }
    end
  end
end
