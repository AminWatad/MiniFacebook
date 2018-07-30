class PostsController < ApplicationController
  def new
    respond_to do |format|
      format.js
    end
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if !(arr = @post.content.scan(/(http.*jpg)/)).empty?
      @url = arr.first.first
      @post.update(content: @post.content.chomp(@url))
    end
    
    if @post.save
      if !@url.nil?
        @img = current_user.images.build(url: arr.first.first,
                                         description: @post.content,
                                          post_id: @post.id)
        @img.save
      end
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
