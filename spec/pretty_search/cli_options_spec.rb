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
      expect(status).to eq 0
    end
  end
end
