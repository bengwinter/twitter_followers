require_relative './db_connect.rb'
require_relative './twitter_connect.rb'

x = 0
y = 0

twitter_client = @rest

Influencer.all.each do |influencer|
  begin
    puts twitter_client.user(influencer.username)
  rescue
     y += 1
    puts y
    if twitter_client === @rest
      twitter_client = @rest_b
    else
      twitter_client = @rest
    end

    sleep(600)
  end

  twitter_client.followers(influencer.twitter_id.to_i, count:  100).to_h[:users].each do |follower|
    User.create(twitter_id: follower[:id_str], username: follower[:screen_name], description: follower[:description], followers_count: follower[:followers_count], friends_count: follower[:friends_count])
    Relationship.create(influencer_id: influencer.twitter_id, user_id: follower[:id_str], relationship_type: "Follower")
  end
  
  twitter_client.friends(influencer.twitter_id.to_i, count:  100).to_h[:users].each do |friend|
    User.create(twitter_id: friend[:id_str], username: friend[:screen_name], description: friend[:description], followers_count: friend[:followers_count], friends_count: friend[:friends_count])
    Relationship.create(influencer_id: influencer.twitter_id, user_id: friend[:id_str], relationship_type: "Friend")
  end
   

  sleep(30)
  x += 1
  puts x
end


puts "Complete"
  