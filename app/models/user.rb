 class User < ActiveRecord::Base
	  has_secure_password
    mount_uploader :avatar, AvatarUploader
    has_many :posts, dependent: :destroy
     
end
