require 'spec_helper'
require 'open3'

RSpec.describe 'CliOptions' do
  describe '#parse_cli_opts' do
    it 'accepts --help' do
      _stdout, _stderr, status = Open3.capture3 './spec/fixtures/cli_test --help'
      expect(status).to eq 0
    end

    it 'accepts --data FILE' do
      _stdout, _stderr, status = Open3.capture3 './spec/fixtures/cli_test --data FILE'
      expect(status).to be_success
    end

    it 'exit with status 1 for unknown flag' do
      _stdout, _stderr, status = Open3.capture3 './spec/fixtures/cli_test --alien-flag'
      expect(status).to_not be_success
    end
  end

  describe 'HELP_TEXT' do
    it 'includes all supported option flags' do
      expect(PrettySearch::HELP_TEXT).to include '--data'
      expect(PrettySearch::HELP_TEXT).to include '--help'
    end
  end
end
