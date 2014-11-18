require 'open-uri'
require 'json'

class Tag
  attr_accessor :tag_name, :answer_count, :answer_score

  def initialize tag_name, answer_count, answer_score
    @tag_name, @answer_count, @answer_score = tag_name, answer_count, answer_score
  end

  #static methods
  
  def self.from_json_tags usr_hash
    Tag.new(usr_hash["tag_name"], usr_hash["answer_count"],
      usr_hash["answer_score"])
  end
  
  def self.top_tags
    api_content = open('http://api.stackexchange.com/2.2/users/22656/top-answer-tags?pagesize=10&site=stackoverflow').read
    parsed_content = JSON.parse(api_content)

    tags = []

    parsed_content["items"].each do |usr|
      tags << Tag.from_json_tags(usr)
    end

    tags
  end
  #instance methods

end
