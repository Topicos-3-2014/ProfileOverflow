class TagsController < ApplicationController
  def show
    @tag = Tag.new(params[:tag_name])
    @top_answerers = @tag.top_answerers
    @related_tags = @tag.related_tags
  end

  def common_answered
    @tag = Tag.new(params[:tag_name])
    @common_answered_tags = @tag.common_answered_tags
    @common_answered_data = @common_answered_tags.map {|u| [u.tag_name, u.answer_count]}
  end
end
