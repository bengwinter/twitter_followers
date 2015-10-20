require_relative './twitter_connect.rb'
require_relative './db_connect.rb'

#Return shoud be an array of members
influencers = JSON.parse(IO.read("./influencers.json"))

influencers.each do |influencer|
  if Influencer.where(username: influencer) === []
    Influencer.create(twitter_id: @rest.user(influencer).id.to_s, username: influencer)
  end
end
  

