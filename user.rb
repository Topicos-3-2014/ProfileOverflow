require 'open-uri'
require 'json'

class User
  attr_accessor :reputation, :age, :display_name, :account_id

  def self.from_json usr_hash
    user = User.new

    user.reputation = usr_hash["reputation"]
    user.age = usr_hash["age"]
    user.display_name = usr_hash["display_name"]
    user.account_id = usr_hash["account_id"]

    user
  end

  def self.top_users
    api_content = open('http://api.stackexchange.com/2.2/users?order=desc&sort=reputation&site=stackoverflow').read
    parsed_content = JSON.parse(api_content)

    top_users = []

    parsed_content["items"].each do |usr|
      top_users << User.from_json(usr)
    end

    top_users
  end
end
