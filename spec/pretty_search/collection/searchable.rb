RSpec.shared_examples 'searchable collection' do
  context 'with SimpleQuery' do
    context 'when there is only a single matche' do
      let(:query) do
        PrettySearch::SimpleQuery.new({ 'suspended' => true })
      end
      it 'returns 1 record' do
        expect(subject.search(query).count).to eq 1
      end
    end

    context 'when there are multiple matches' do
      let(:query) do
        PrettySearch::SimpleQuery.new({ 'suspended' => false })
      end
      it 'returns all records' do
        expect(subject.search(query).count).to eq 2
      end
    end

    context 'when there are no matches' do
      let(:query) do
        PrettySearch::SimpleQuery.new({ 'suspended' => 'non-existing-value' })
      end
      it 'returns empty' do
        expect(subject.search(query)).to be_empty
      end
    end
  end
end
