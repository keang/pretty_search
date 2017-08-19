require 'spec_helper'
require 'pretty_search/collection/searchable'

RSpec.describe PrettySearch::MemoryCollection do
  let(:data_file) { './spec/fixtures/users.json' }
  subject { described_class.new(data_file) }
  it_behaves_like 'searchable collection'
end
