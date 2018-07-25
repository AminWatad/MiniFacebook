class PostsController < ApplicationController
  def create
    @post = current_user.posts.build(post_params)

    if @post.save
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
