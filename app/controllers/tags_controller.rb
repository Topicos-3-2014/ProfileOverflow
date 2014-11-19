class TagsController < ApplicationController
  def show
    @tag = Tag.new(params[:tag_name])
    @top_answerers = @tag.top_answerers
    @related_tags = @tag.related_tags
  end

  def common_answered
    @tag = Tag.new(params[:tag_name])
    @common_answered_tags = @tag.common_answered_tags
    hsh = Hash.new(0)
    @common_answered_tags.each do |tag|
      hsh[tag.tag_name] += tag.answer_count.to_i
    end

    @common_answered_data = hsh.to_a
  end
end
