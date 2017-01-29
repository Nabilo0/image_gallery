class PostsController < ApplicationController

	def index
 	  # @user = User.find_by(params[:id])
 	  # byebug
		# @post = @user.posts.where(user_id: current_user)
		# byebug

		# @user = User.find(current_user)
  # 		@post = @user.posts
 		@post = User.find(params[:user_id]).posts

 	end

	def show

	end

	def new
		@post = Post.new
	end
	def create
		@post = current_user.posts.create(post_param)
		if @post.save
			 redirect_to user_path(current_user)
		else

		end
	end


	private
	def post_param
		params.require(:post).permit(:discarption, :avatar, :user_id)
	end
end
