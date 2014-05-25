#!/bin/env ruby
#encoding:UTF-8
require "twitter"
require "yahoo_keyphrase_api"

# Twitter Access Token Setting
@client = Twitter::REST::Client.new do |config|
	config.consumer_key = "****"
	config.consumer_secret = "****"
	config.access_token = "****"
	config.access_token_secret = "****"
end

YahooKeyphraseApi::Config.app_id = "YahooDeveloperID"
ykp = YahooKeyphraseApi::KeyPhrase.new


def word_search_result(target="")
	@return_text=""
	@client.search(target, :result_type => "recent").take(200).each do |tweet|
		@return_text += tweet.text.gsub(target, "")
	end
	return @return_text
end


begin
  target_word = ARGV[0]
	phrases = word_search_result(target_word)
	p ykp.extract(phrases)
rescue Twitter::Error::ClientError
	p "Error!"
  sleep(5)
	retry
end
