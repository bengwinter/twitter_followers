require 'pry'
require 'csv'
require 'json'
require 'date'
require 'pg'
require 'active_record'



begin
  ActiveRecord::Base.establish_connection(
    :adapter  => "postgresql",
    :host     => "localhost",
    :port     => 5432,
    :database => "twitter_data_development"
  )  
rescue
  puts "Error Connecting to DB"
  exit 1
end

class User < ActiveRecord::Base
  validates_uniqueness_of :twitter_id
end

class Relationship < ActiveRecord::Base
  validates_uniqueness_of :user_id, scope: [:influencer_id, :relationship_type]
end

class Influencer < ActiveRecord::Base
  validates_uniqueness_of :twitter_id
end