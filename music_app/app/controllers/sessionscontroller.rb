class SessionsController
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:email]
      params[:user][:password]
    )

    if user
      login_user!(user)
    else
      flash.now[:errors] = ["Invalid user credentials!"]
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end
end
