class LikesController < ApplicationController
  
  def show
    @post= Post.find(params[:post_id])
    
    respond_to do |format|
      format.js
    end
  end

  def create
    @post = Post.find(params[:post_id])
    current_user.like(@post)
    respond_to do |format|
      format.html { redirect_to current_user }
      format.js
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    current_user.unlike(@post)
    respond_to do |format|
      format.html { redirect_to current_user }
      format.js
    end
  end

end
