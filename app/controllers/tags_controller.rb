class TagsController < ApplicationController
  def show
    @tag = Tag.new(params[:tag_name])
    @top_answerers = @tag.top_answerers
    @related_tags = @tag.related_tags
  end

  def common_answered
    @tag = Tag.new(params[:tag_name])
    @common_answered_tags = @tag.common_answered_tags
    h1 = Hash.new(0)
    @common_answered_tags.each do |tag|
      h1[tag.tag_name] += tag.answer_count.to_i
    end

    @common_answered_data = h1.to_a

    @filtered_common = @tag.filtered_common_tags

    h2 = Hash.new(0)
    @filtered_common.each do |tag|
      h2[tag.tag_name] += tag.answer_count.to_i
    end

    @filtered_data = h2.to_a
  end
end
