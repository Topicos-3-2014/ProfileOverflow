class ChartsController < ApplicationController
  def index
    @top_users = User.top_users
    @top_users_chart_data = @top_users.map {|u| [u.display_name, u.reputation]}
    
    
    ages = []
    
    User.top_users.each do |tops|
      ages << tops.age
    end
    
    
    h = Hash.new(0)
    ages.each { | v | h.store(v, h[v]+1) }
    puts h
    
    @top_users_age_data = h
    
  end
end
