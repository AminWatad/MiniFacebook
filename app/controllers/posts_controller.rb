class PostsController < ApplicationController
  def new
    respond_to do |format|
      format.js
    end
  end
  
  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      current_user.activities.create(kind: "post", target_id: @post.id)
      redirect_to authenticated_root_path
    else
      render 'profile/show'
    end
  end

  

  private 
  def post_params
    params.require(:post).permit([:content])
  end
end
