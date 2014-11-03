require 'open-uri'
require 'json'

class User
  attr_accessor :id, :reputation, :age, :display_name, :account_id

  def initialize id, reputation, age, display_name, account_id
    @id, @reputation, @age, @display_name, @account_id = id, reputation, age, display_name, account_id
  end

  #static methods
  def self.from_json usr_hash
    User.new(usr_hash["user_id"], usr_hash["reputation"],
      usr_hash["age"], usr_hash["display_name"], usr_hash["account_id"])
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

  #instance methods

end
