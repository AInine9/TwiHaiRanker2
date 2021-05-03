class HomeController < ApplicationController
  def index
    @ranking = Ranking.all.order(tweetsperday: "DESC")
    @users = User.all
  end
end
