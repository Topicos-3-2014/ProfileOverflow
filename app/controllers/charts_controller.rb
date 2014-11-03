class ChartsController < ApplicationController
  def index
    @top_users = User.top_users
    @top_users_chart_data = @top_users.map {|u| [u.display_name, u.reputation]}
  end
end
