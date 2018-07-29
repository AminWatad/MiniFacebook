class ImagesController < ApplicationController
  def new
    @image = current_user.images.build

    respond_to do |format|
      format.js
    end
  end

  def create
    @image = current_user.images.build(image_params)

    if @image.save
      redirect_to authenticated_root_path
    else
      redirect_to profile_path(current_user)
    end
  end

  def show
  end

  private
  def image_params
    params.require(:image).permit([:url, :description])
  end
end
