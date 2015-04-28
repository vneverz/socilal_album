class PhotosController < ApplicationController

  before_action :authenticate_user!, :except => [:index]

  def index
    @photos = Photo.page(params[:page])
    @photo = Photo.new
  end
  # add to pop up
  # def new
  #  @photo = Photo.new
  # end
  def create
    @photo = Photo.new( photo_params )

    if @photo.save
      redirect_to root_url
    else
      render :action => :new
    end
  end

  protected

  def photo_params
    params.require(:photo).permit(:content, :image)
  end
end
