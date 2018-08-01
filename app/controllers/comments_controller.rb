class CommentsController < ApplicationController
  
  def show
    @post = Post.find(params[:post_id])

    respond_to do |format|
      format.js
    end
  end

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
    if @comment.save
      current_user.activities.create(target_id: @post.id, kind: "comment",
                                     user_target_id: @post.user.id)
    end
    @comments = @post.comments
    respond_to do |format|
      format.js
    end
  end

end
