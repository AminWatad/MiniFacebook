class HomeController < ApplicationController
  def index
    @feed = current_user.feed
  end

end
