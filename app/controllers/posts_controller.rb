class PostsController < ApplicationController
  skip_before_filter :verify_authenticity_token

	def index
 	  # @user = User.find_by(params[:id])
		 # byebug
				# @post = @user.posts.where(user_id: current_user)
				# byebug
			# @user = User.find(current_user)
		# @post = @user.posts
		# @user = User.find_by_id(current_user)
 	  # @user = User.find_by(params[:id])

 		@post = User.find(params[:user_id]).posts

 	end

	def show

	end

	def new
		@post = Post.new
	end

	def create
		@post = current_user.posts.create(post_param)
			
    	respond_to do |format|
      if @post.save
        format.html { redirect_to user_posts_path(current_user) , notice: 'Post was successfully created.' }
        format.json

         # format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
	end
	def destroy
		@post = Post.find(params[:id])
			@post.destroy
			respond_to do |format|
        format.html { redirect_to user_posts_path(current_user)  }
        format.json
	end
end

	private
	def post_param
		params.require(:post).permit(:discarption, :avatar, :user_id)
	end
end
