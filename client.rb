require 'json'
require 'rest-client'
require 'base64'
require 'yaml'
require_relative 'parser'

module Twitter
  CONFIG       = YAML.load_file('config.yml')
  API_URI      = CONFIG['api_uri']
  TOKEN_URI    = CONFIG['token_uri']
  TRENDS_PATH  = CONFIG['trends_path']
  GLOBAL_WOEID = CONFIG['global_woeid']

  class Client
    include Parser

    def initialize
      @token = get_token
    end

    # Fetches the trending topics
    #
    # @param woeid [Fixnum] the woeid of the location
    # @return [Array<String>] an array of trending topics
    def fetch_trends(woeid = GLOBAL_WOEID)
      opts = { path: TRENDS_PATH, params: { id: woeid } }
      parse_trends(get(opts))
    end

    private

    def get(opts = {})
      path   = opts.fetch(:path)
      params = URI.encode_www_form(opts.fetch(:params, {}))
      url    = URI.encode("#{API_URI}#{path}?#{params}")
      RestClient.get(url, request_header)
    end

    def get_token
      body = { grant_type: 'client_credentials' }
      response = RestClient.post(TOKEN_URI, body, auth_header)
      JSON.parse(response.body)['access_token']
    end

    def auth_header
      authorization = Base64.strict_encode64("#{CONFIG['key']}:#{CONFIG['secret']}")
      { 'Authorization' => "Basic #{authorization}" }
    end

    def request_header
      { 'Authorization' => "Bearer #{@token}" }
    end
  end
end

