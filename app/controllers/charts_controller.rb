class ChartsController < ApplicationController
  def index
    @top_users = User.top_users
    @tags = Tag.top_tags
    @top_countries = Country.top_countries
    @top_users_chart_data = @top_users.map {|u| [u.display_name, u.reputation]}
    @top_user_tag = @tags.map {|u| [u.tag_name, u.answer_score]}
    
    
    ages = []
    
    User.top_users.each do |tops|
      ages << tops.age
    end
    
    countries = []
    
    Country.top_countries.each do |top_countries|
      countries << top_countries.location
    end
    
    
    h = Hash.new(0)
    countries.each { | v | h.store(v, h[v]+1) }
    puts h
    
    @top_users_age_data = h
    @top_user_country = h
  end
end