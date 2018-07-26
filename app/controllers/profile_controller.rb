class ProfileController < ApplicationController
  def show
    begin
      @user = User.find(params[:id]);
      @post = current_user.posts.new
      @posts = @user.posts.all
    rescue
      redirect_to authenticated_root_path
    end
  end
end
