class UsersController < ApplicationController
	def show
		@user = User.find_by_id(params[:id])
 	end

def new
end

def create
	user = User.new(new_user)
	if user.save
		session[:user_id] = user.id
		redirect_to '/'
		flash[:notice] = "Successfully created a new user"

 else
	redirect_to '/signip'
end
	end

def edit
	@user = User.find(params[:id])
end

def update
	@user = User.find(params[:id])
		@user.update(new_user)
			if @user.save
				redirect_to user_path(current_user)
					flash[:notice] = "Successfully updated"
			else
					redirect_to edit_user_path(current_user)
				flash[:notice] = "Error"
		end
end

def destroy
		@user = User.find(current_user)
			@user.destroy
		redirect_to logout_path
# 		flash[:notice] = "Successfully Deleted"
end

 def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  def all
  	@user = User.all
  end

	private

	def new_user
	params.require(:user).permit(:nick_name, :first_name, :last_name,:email, :password, :avatar, :access_level)

	end
end
