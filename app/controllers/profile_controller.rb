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

  def request_friendship
    @user = User.find(params[:user_id])
    current_user.request(@user)

    respond_to do |format|
      format.js
    end
  end 

  def delete_request
    @user = User.find(params[:user_id])
    @user.unrequest(current_user)

    respond_to do |format|
      format.js
    end
  end

  def accept
    @user = User.find(params[:user_id])
    if current_user.requested_by?(@user)
      current_user.befriend(@user)
      @user.befriend(current_user)

      @user.unrequest(current_user)
    end

    respond_to do |format|
      format.js
    end
  end

  def decline
    @user = User.find(params[:user_id])
    current_user.unrequest(@user)

    respond_to do |format|
      format.js
    end
  end
end
