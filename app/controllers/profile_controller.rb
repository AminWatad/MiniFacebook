class ProfileController < ApplicationController
  def show
    @user = current_user
    @post = current_user.posts.new
    @posts = @user.posts.all
  end
end
