require 'grackle'

class Tweet < ActiveRecord::Base

  MY_APPLICATION_NAME = "neerajtest"
  
  """Connect to the Twitter API and pull down the latest tweets"""
  def self.get_latest
    tweets = client.statuses.user_timeline? :screen_name => MY_APPLICATION_NAME # hit the API
    tweets.each do |t|
      created = DateTime.parse(t.created_at)
      # create the tweet if it doesn't already exist
      unless Tweet.exists?(["created=?", created])
        Tweet.create({:content => t.text, :created => created })
       end
    end
  end
  
  private
  def self.client
    Grackle::Client.new(:auth=>{
      :type=>:oauth,
      :consumer_key=>'9dwU40B7KOugGWsO6KiQng',
      :consumer_secret=>'SpAiN8jifSF0RFn1iaV1JdR862hJTJdC11f7nl5iWaI',
      :token=>"http://twitter.com/oauth/access_token",
      :token_secret=>"http://twitter.com/oauth/authorize"
    })

  end
end