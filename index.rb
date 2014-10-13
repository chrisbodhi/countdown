require 'sinatra'
require 'twitter'

set :server, 'webrick'

def countdown
  go_time = Time.parse('2015-04-03 18:00:00')
  now = Time.now
  time_left_in_seconds = go_time - now
  time_left_in_days = (time_left_in_seconds.to_i)/60/60/24
  if time_left_in_days == 1
    return "Selection is tomorrow. Make sure your mind is right."
  elsif time_left_in_days == 0
    return "It's time."
  else
    return "#{time_left_in_days} days left to Selection. What are you doing today?\n"
  end
end

def twitter_post
  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV['CONSUMER_KEY']
    config.consumer_secret     = ENV['CONSUMER_SECRET']
    config.access_token        = ENV['OAUTH_TOKEN']   # Technically no longer the term, but
    config.access_token_secret = ENV['OAUTH_SECRET']  # they're the names that're stored
  end

  client.update(countdown)
end

get '/' do
  countdown
end