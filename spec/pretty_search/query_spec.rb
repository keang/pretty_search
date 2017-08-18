require "spec_helper"

RSpec.describe PrettySearch::SimpleQuery do
  let(:query) { described_class.new({'a'=>2.1, 'b' => true, 'c' => 'string'}) }
  describe '#match' do
    it 'is true for whole value matches' do
      expect(query.match({
        'a'=>2.1,
        'b'=>true,
        'c'=>'string',
        'd'=>'redundant'
      })).to be_truthy
    end

    it 'is false when not all values matches' do
      expect(query.match({
        'a'=>2.10001,
        'b'=>true,
        'c'=>'string',
        'd'=>'redundant'
      })).to be_falsey
      expect(query.match({
        'a'=>2.1,
        'b'=>true,
        'c'=>'string2',
        'd'=>'redundant'
      })).to be_falsey
      expect(query.match({
        'a'=>2.1,
        'b'=>true,
        'd'=>'redundant'
      })).to be_falsey
      expect(query.match({
        'a'=>2.1,
        'b'=>'true',
        'c'=>'string',
        'd'=>'redundant'
      })).to be_falsey
    end
  end
end
