require 'spec_helper'
require 'open3'

RSpec.describe CliOptions do
  describe '#parse_cli_opts' do
    it 'accepts --help' do
      _stdout, _stderr, status = Open3.capture3 './spec/fixtures/cli_test --help'
      expect(status).to eq 0
    end

    it 'accepts --data FILE' do
      _stdout, _stderr, status = Open3.capture3 './spec/fixtures/cli_test --data FILE'
      expect(status).to eq 0
    end
  end

  describe '#parse_query' do
    valid_cases = [
      # [query_args, expected_result],
      [['name=value to match'], { 'name' => 'value to match' }],
      [['shared=false'], { 'shared' => false }],
      [['shared  =  false'], { 'shared' => false }],
      [['_id  =  3'], { '_id' => 3 }],
      [['op=+'], { 'op' => '+' }],
      [['last_login_at=2013-08-04T01:03:27 -10:00'], { 'last_login_at' => '2013-08-04T01:03:27 -10:00' }]
    ]
    valid_cases.each do |query, result|
      it "parses a single field: #{query}" do
        expect(described_class.parse_query(query)).to eq(result)
      end
    end

    it 'raises error for invalid argument' do
      expect do
        described_class.parse_query(['name='])
      end.to raise_error(CliOptions::InvalidQuery)
    end
  end
end
