class TagsController < ApplicationController
  def show
    @tag = Tag.new(params[:tag_name])
    @top_answerers = @tag.top_answerers
    @related_tags = @tag.related_tags
  end
end
