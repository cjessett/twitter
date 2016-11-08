module Twitter
  module Parser

    # Parses trending tweets from a response
    #
    # @param response [#body] an HTTP response object that responds to #body
    # @return [Array<String>] an array of trending topics from the response
    def parse_trends(response)
      JSON.parse(response.body)[0]['trends'].map { |trend| trend['name'] }
    end

    def parse_hashtag_tweets(response)
      JSON.parse(response.body)['statuses'].map { |tweet| tweet['text'] }
    end
  end
end
