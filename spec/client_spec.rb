require 'spec_helper'
require 'client'

describe Twitter::Client do
  before do
    stub_auth
    @client = Twitter::Client.new
  end

  describe '#initialize' do
    it 'is initialized with a token' do
      expect(@client.token).to eq 'fake_token'
    end
  end
end

def stub_auth
  stub_request(:post, Twitter::Client::TOKEN_URI)
  .to_return(status: 200, body: json({access_token: 'fake_token'}), headers: {})
end
