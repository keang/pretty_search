require 'spec_helper'
require 'open3'

RSpec.describe 'CliOptions' do
  describe '#parse_cli_opts' do
    [
      '--help',
      '--data FILE',
      '--data FILE --first',
    ].each do |options|
      it "accepts #{options}" do
        _stdout, _stderr, status = Open3.capture3 "./spec/fixtures/cli_test #{options}"
        expect(status).to eq 0
      end
    end

    it 'exit with status 1 for unknown flag' do
      _stdout, _stderr, status = Open3.capture3 './spec/fixtures/cli_test --data FILE --alien-flag'
      expect(status).to_not be_success
    end
  end

  describe 'HELP_TEXT' do
    it 'includes all supported option flags' do
      %w(data help large first).each do |flag|
        expect(PrettySearch::HELP_TEXT).to include "--#{flag}"
      end
    end
  end
end
