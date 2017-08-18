require "spec_helper"

RSpec.describe PrettySearch::Document do
  describe '#to_str' do
    it 'is a pretty json' do
      list = [
        described_class.new({a: 1, b: 2, c: [1, 2]}),
        described_class.new({a: 7, b: 8, c: [7, 8]}),
      ]
      expected = <<-EOF.chop
{
  "a": 1,
  "b": 2,
  "c": [
    1,
    2
  ]
}
{
  "a": 7,
  "b": 8,
  "c": [
    7,
    8
  ]
}
EOF
      expect(list.join("\n")).to eq expected
    end
  end
end
