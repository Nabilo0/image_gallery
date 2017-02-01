class SessionsController < ApplicationController

	def new
	end

 def create

    user = User.find_by_email(params[:email])
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user 
      # logged in when they navigate around our website.
      session[:user_id] = user.id
      redirect_to '/'
		  flash[:notice] = "Successfully Login"

    else
    # If user's login doesn't work, send them back to the login form.
      redirect_to '/login'
      flash[:notice] = "Error Login"

    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

    def create_with_instagram
    #     @auth = request.env['omniauth.auth']
    # omniauth = request.env['omniauth.auth']
     # byebug
    user = User.from_omniauth(auth_hash)
    # byebug
    # render :text => auth_hash.inspect
    # current_user = user.id
    session[:user_id] = user.id

    redirect_to user_path(current_user)
  end


  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
