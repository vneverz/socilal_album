class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :photos
  devise :omniauthable, :omniauth_providers => [:facebook]

  def is_admin?
  	self.role == "admin"
  end

  def self.from_omniauth(auth)
	  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
	    user.email = auth.info.email
	    user.password = Devise.friendly_token[0,20]
	    user.username = auth.info.name   # assuming the user model has a name
	    user.fb_image = auth.info.image # assuming the user model has an image
	    user.fb_uid = auth.info.fb_uid # assuming the user model has an uid
	  end
	end
	def self.new_with_session(params, session)
		super.tap do |user|
		  if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
		    user.email = data["email"] if user.email.blank?
		    user.fb_image = data["image"] if user.fb_image.blank?
		  end
		end
	end

	has_many :my_photos, :class_name => "Photo"
  	has_many :likes
  	has_many :like_photos, :through => :likes, :source => "photo"

end
