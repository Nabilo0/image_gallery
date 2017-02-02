 class User < ActiveRecord::Base
    include Messenger
    include PgSearch
    # multisearchable :against => [:nick_name, :first_name]
    validates_confirmation_of :password

  # this for test model
  # ##################################
   # validates_presence_of :password
   # validates_presence_of :email
    validates :email, uniqueness: true
# ##################################
 # validates :email, format: {with: /\A([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})\z/,
 # message: "Your Email should Be like : example@exaple.com"}

     pg_search_scope :search,
                  against: [
                    :nick_name,
                    :first_name,
                    :email
                  ],
                  using: {
                    tsearch: {
                      prefix: true,
                      normalization: 2
                    }
                  }
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

    enum access_level: [:ordinary, :admin, :king_kong]

      # scope :nick_name, -> (nick_name) {where("nick_name like ?", "#{nick_name}")}
      # scope :first_name -> (first_name) {where("first_name like ?", "#{first_name}")}
 def clean_number
  @num = self.phone.scan(/\d+/).join
  # byebug
  # phone[0] == '1' ? phone[0] = '' : phone
  # phone unless phone.length != 16
end

  def self.perform_search(keyword)
    if keyword.present?
      then User.search(keyword)
       else 
      all
    end
  end

# def self.search(search)
#   if search
#     where(["nick_name LIKE ?","%#{search}%"])
#     where(["first_name LIKE ?","%#{search}%"])
#     where(["email LIKE ?","%#{search}%"])
#     else
#     all
#     end
#   end

def self.from_omniauth(auth_hash)
     # user = User.create!(first_name: auth_hash["extra"]["raw_info"]["first_name"], last_name: auth_hash["extra"]["raw_info"]["last_name"], email: auth_hash["extra"]["raw_info"]["email"])

    user = find_by(provider: auth_hash.provider, uid: auth_hash.uid)
    user = create(uid: auth_hash.uid, provider: auth_hash.provider,:first_name => auth_hash['info']['firstname'], :nick_name => auth_hash['info']['nickname'], :password => auth_hash['uid'], :avatar => auth_hash["image"]) if user.nil?
        # user = create(:first_name => auth_hash['info']['firstname'], :nick_name => auth_hash['info']['name'], :password => auth_hash['uid'] )
    user.accesstoken = auth_hash.credentials.token
    # user.password = '   '
    user.refreshtoken = auth_hash.credentials.refresh_token
    # user.email = auth_hash.email
    # user.nick_name = auth_hash.info.username
    # user.email = auth_hash['info']['email']
    # user.nick_name = auth_hash['info']['username']
  user.save!
    user
    # where(provider: auth_hash.provider, uid: auth_hash.uid).first_or_initialize.tap do |user|
    # user.provider = auth_hash.provider
    # user.uid = auth_hash.uid
    # user.first_name = auth_hash.info.first_name
    # user.acesstoken = auth_hash.credentials.token
    #  user.save
    #  user
  #-----------
    # user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
    # user.nick_name = auth_hash['info']['username']
    # byebug
    # user.avatar = auth_hash['info']['image']
    # # user.urls = auth_hash['info']['urls']['instagram']
    # user.password = ' '
    # user.save!
    # user
   
  end

      
  def instagram
    user.where( :provider => "instagram" ).first
  end

  def instagram_client
    @instagram_client ||= Instagram.client( access_token: instagram.accesstoken )
  end    

 

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
