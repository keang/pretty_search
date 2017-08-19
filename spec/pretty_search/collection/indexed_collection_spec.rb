require 'spec_helper'
require 'pretty_search/collection/searchable'

RSpec.describe PrettySearch::IndexedCollection do
  let(:data_file) { './spec/fixtures/users.json' }
  subject { described_class.new(data_file, index_field: 'suspended') }
  it_behaves_like 'searchable collection'
end
