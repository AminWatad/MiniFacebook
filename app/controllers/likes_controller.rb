class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    current_user.like(@post)
    respond_to do |format|
      format.html { redirect_to current_user }
      format.js
    end
  end

  def destroy
    
  end

end
