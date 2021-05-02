class HomeController < ApplicationController
  def index
    @ranking = Ranking.order("tweetsperday DESC")
    @users = User.all
  end
end
