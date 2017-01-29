class UsersController < ApplicationController

	

	def index

	end

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

				@user.send_sms(@user.phone)

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
		 # @user = User.search(params[:search]).all
  	 # @user = User.all
		 # @user = PgSearch.multisearch(params[:search])
	if params[:search].present?
      @user = User.perform_search(params[:search])
    		else
      @user = User.all
	end
end

def send_text
		@num = User.new(new_user)
		# byebug
		# @after_scan = @num.clean_number
		# @num.clean_number
		# byebug
		@num.send_sms(@num.phone)#()
		redirect_to root_path
		      flash[:danger] = ".Done"

	end

	private
	 
	def new_user
	params.require(:user).permit(:nick_name, :first_name, :last_name, :phone, :email, :password, :avatar, :access_level)

	end
end
