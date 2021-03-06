require 'spec_helper'

RSpec.describe PrettySearch::SimpleQuery do
  describe '#self.parse' do
    valid_cases = [
      # [query_args, expected_result],
      [
        ['name=value to match'],
        PrettySearch::SimpleQuery.new('name' => 'value to match')
      ],
      [
        ['name=value to match', 'shared=false', 'id=3'],
        PrettySearch::SimpleQuery.new('name' => 'value to match',
                                      'shared' => false,
                                      'id'     => 3)
      ],
      [
        ['shared  =  false'],
        PrettySearch::SimpleQuery.new('shared' => false)
      ],
      [
        ['credit=1.2234123412341243'],
        PrettySearch::SimpleQuery.new('credit' => 1.2234123412341243)
      ],
      [
        ['op=+'],
        PrettySearch::SimpleQuery.new('op' => '+')
      ],
      [
        ['last_login_at=2013-08-04T01:03:27 -10:00'],
        PrettySearch::SimpleQuery.new('last_login_at' => '2013-08-04T01:03:27 -10:00')
      ]
    ]
    valid_cases.each do |query, result|
      it "parses a single field: #{query}" do
        expect(PrettySearch::Query.parse(query)).to eq(result)
      end
    end

    it 'raises error for invalid argument' do
      expect do
        PrettySearch::Query.parse(['some=thing', 'name='])
      end.to raise_error(PrettySearch::Query::InvalidQuery)
    end
  end

  let(:query) { described_class.new('a' => 2.1, 'b' => true, 'c' => 'string') }
  describe '#match' do
    it 'is true for whole value matches' do
      expect(query.match({
        'a' => 2.1,
        'b' => true,
        'c' => 'string',
        'd' => 'redundant'
      })).to be_truthy
    end

    it 'is false when not all values matches' do
      expect(query.match({
        'a' => 2.10001,
        'b' => true,
        'c' => 'string',
        'd' => 'redundant'
      })).to be_falsey
      expect(query.match({
        'a' => 2.1,
        'b' => true,
        'c' => 'string2',
        'd' => 'redundant'
      })).to be_falsey
      expect(query.match({
        'a' => 2.1,
        'b' => true,
        'd' => 'redundant'
      })).to be_falsey
      expect(query.match({
        'a' => 2.1,
        'b' => 'true',
        'c' => 'string',
        'd' => 'redundant'
      })).to be_falsey
    end

    it 'checks for array inclusion' do
      query = described_class.new('a'=>'v')
      expect(query.match({
        'a' => ['v', 's']
      })).to be_truthy
      expect(query.match({
        'a' => ['x', 'y']
      })).to be_falsey
    end
  end
end
