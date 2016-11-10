require_relative 'client'

module Twitter
  module App
    TRENDS_OPTION  = '1'
    HASHTAG_OPTION = '2'
    USER_OPTION    = '3'
    QUIT_KEY       = 'q'

    # Displays menu and handles user input
    def self.run
      client = Twitter::Client.new
      loop do
        display_menu
        handle_input(gets.chomp, client)
      end
    end

    private

    def self.handle_input(input, client)
      case input
      when TRENDS_OPTION
        display_trends(client.fetch_trends)
      when HASHTAG_OPTION
        puts 'Enter a hashtag:'
        display_tweets(client.fetch_tweets_by_hashtag(gets.chomp))
      when USER_OPTION
        puts 'Enter a username:'
        display_tweets(client.fetch_tweets_by_user(gets.chomp))
      when QUIT_KEY
        exit
      end
    end

    def self.display_menu
      puts "\n What would you like to do?"
      puts "#{TRENDS_OPTION}. See global trending topics"
      puts "#{HASHTAG_OPTION}. See tweets by hashtag"
      puts "#{USER_OPTION}. See tweets by user"
      puts "Type #{QUIT_KEY} to quit \n"
    end

    def self.display_trends(trends)
      trends.each { |t| puts "\n#{t}\n"}
    end

    def self.display_tweets(tweets)
      tweets.each { |t| puts "\n#{t}\n\n---"}
    end
  end
end
