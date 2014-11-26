require 'open-uri'
require 'json'

class Tag
  attr_accessor :tag_name, :answer_count, :answer_score

  def initialize tag_name, answer_count = 0, answer_score = 0
    @tag_name, @answer_count, @answer_score = tag_name, answer_count, answer_score
  end

  #static methods

  def self.from_json tag_hash
    Tag.new(tag_hash["tag_name"], tag_hash["answer_count"],
      tag_hash["answer_score"])
  end

  def self.from_related tag_hash
    Tag.new(tag_hash["name"], tag_hash["count"])
  end

  def self.top_tags
    api_content = open('http://api.stackexchange.com/2.2/users/22656/top-answer-tags?pagesize=10&site=stackoverflow').read
    parsed_content = JSON.parse(api_content)

    tags = []

    parsed_content["items"].each do |tag|
      tags << Tag.from_json(tag)
    end

    tags
  end

  #instance methods

  def top_answerers
    api_content = open("http://api.stackexchange.com/2.2/tags/#{@tag_name}/top-answerers/all_time?site=stackoverflow").read
    parsed_content = JSON.parse(api_content)

    top_answerers = []

    parsed_content["items"].each do |answerer|
      top_answerers << User.from_json(answerer["user"])
    end

    top_answerers
  end

  def related_tags
    api_content = open("http://api.stackexchange.com/2.2/tags/#{@tag_name}/related?site=stackoverflow").read
    parsed_content = JSON.parse(api_content)

    related_tags = []

    parsed_content["items"].each do |related|
      related_tags << Tag.from_related(related)
    end

    related_tags
  end

  def common_answered_tags
    answerers = self.top_answerers

    answerers_ids = ""
    for i in (0...answerers.count-1)
      answerers_ids += answerers[i].id.to_s + ";"
    end

    answerers_ids += answerers[answerers.count-1].id.to_s

    api_content = open("http://api.stackexchange.com/2.2/users/#{answerers_ids}/tags?order=desc&sort=popular&site=stackoverflow").read
    parsed_content = JSON.parse(api_content)

    answered_tags = []

    parsed_content["items"].each do |answered|
      answered_tags << Tag.from_related(answered)
    end

    answered_tags
  end

  def filtered_common_tags
    common = self.common_answered_tags
    related = self.related_tags

    result = []

    common.each do |c|
      result << c unless (Tag.is_tag_in_collection c, related) or c.tag_name == self.tag_name
    end

    result
  end

  private

  def self.is_tag_in_collection tag, collection
    collection.each do |elm|
      if elm.tag_name == tag.tag_name
        return true
      end
    end

    return false
  end

end
