class CommentsController < ApplicationController
  def new
    @comment = current_user.comments.build
    @post = Post.find(params[:post_id])

    respond_to do |format|
      format.js
    end
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(post_id: @post.id,
                                        content: params[:comment][:content])
    @comment.save

    respond_to do |format|
      format.js
    end
  end

end
