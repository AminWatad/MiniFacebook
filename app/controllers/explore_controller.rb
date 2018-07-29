class ExploreController < ApplicationController
  def index
    @posts = Post.all
    @images = Image.all
    @feed = []
    @feed << @posts
    @feed << @images
  end
end
