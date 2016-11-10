require 'spec_helper'
require 'client'

describe Twitter::Client do
  before do
    stub_auth
    @client = Twitter::Client.new
  end

  describe '#initialize' do
    it 'is initialized with a token' do
      expect(@client.instance_variable_get(:@token)).to eq 'fake_token'
    end
  end

  describe '#fetch_trends' do
    before do
      stub_request(:get, /.*#{Twitter::TRENDS_PATH}.*/)
      .to_return(status: 200, body: json([{trends: [{name: 'foo'}, {name: 'bar'}]}]), headers: {})
    end

    it 'returns an array of trend names' do
      expect(@client.fetch_trends).to match_array ['foo', 'bar']
    end
  end

  describe '#fetch_tweets_by_hashtag' do
    before do
      stub_request(:get, /.*#{Twitter::SEARCH_PATH}.*/)
      .to_return(status: 200, body: json({statuses: [{text: 'tweet1'}, {text: 'tweet2'}]}), headers: {})
    end

    it 'returns an array of tweets' do
      expect(@client.fetch_tweets_by_hashtag('#hashtag')).to match_array ['tweet1', 'tweet2']
    end
  end

  describe '#fetch_tweets_by_user' do
    before do
      stub_request(:get, /.*#{Twitter::USER_PATH}.*/)
      .to_return(status: 200, body: json([{text: 'tweet1'}, {text: 'tweet2'}]), headers: {})
    end

    it 'returns an array of tweets' do
      expect(@client.fetch_tweets_by_user('user')).to match_array ['tweet1', 'tweet2']
    end
  end
end
