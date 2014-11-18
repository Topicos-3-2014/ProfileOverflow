require 'open-uri'
require 'json'

class Country
  attr_accessor :location

  def initialize location
    @location = location
  end

  #static methods
  
  def self.from_json_countries usr_hash
    Country.new(usr_hash["location"])
  end
  
    def self.top_countries
    api_content = open('http://api.stackexchange.com/2.2/users?order=desc&sort=reputation&site=stackoverflow').read
    parsed_content = JSON.parse(api_content)

      countries = []

    parsed_content["items"].each do |usr|
      countries << Country.from_json_countries(usr)
    end

    countries
  end
  #instance methods

end
