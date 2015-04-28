class LikesController < ApplicationController

  before_action :authenticate_user!
  
	def create
    photo = Photo.find( params[:photo_id] )

    # 要先判斷這個like是否有被按過
    like = photo.find_like_by_user(current_user)
    unless like
      Like.create( :user => current_user, :photo => photo)
    end

    redirect_to :back
  end

  def destroy
    like = current_user.likes.find( params[:id] )
    like.destroy

    redirect_to :back
  end
end
