require 'json'
require 'rest-client'
require 'base64'

module Twitter
  CONFIG = YAML.load_file('config.yml')

  class Client
    API_URI   = 'https://api.twitter.com/1.1'.freeze
    TOKEN_URI = 'https://api.twitter.com/oauth2/token'.freeze

    attr_reader :token

    def initialize
      @token = get_token
    end

    private

    def get_token
      body = { grant_type: 'client_credentials' }
      response = RestClient.post(TOKEN_URI, body, auth_header)
      JSON.parse(response.body)['access_token']
    end

    def auth_header
      authorization = Base64.strict_encode64("#{CONFIG['KEY']}:#{CONFIG['SECRET']}")
      { 'Authorization' => "Basic #{authorization}" }
    end
  end
end

