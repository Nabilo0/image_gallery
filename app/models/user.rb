 class User < ActiveRecord::Base
    has_secure_password
    mount_uploader :avatar, AvatarUploader
    has_many :posts, dependent: :destroy
     
    has_many :active_relationships, class_name:  "Relationship",
                                   foreign_key: "follower_id",
                                   dependent:   :destroy

    has_many :passive_relationships, class_name:  "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy

	 	has_many :following, through: :active_relationships, source: :followed
  	has_many :followers, through: :passive_relationships, source: :follower

 	def follow(other_user)
   following << other_user
    # relationships.create(followed_id: other_user.id)
  end

      # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)

     # relationships.find_by(followed_id: other_user.id).destroy
  end

     # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
      # relationships.find_by(followed_id: other_user.id) 
  end

end
