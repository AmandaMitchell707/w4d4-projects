class SessionsController
  before_action :require_login, only: [:destroy]
  before_action :require_logout, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:email]
      params[:user][:password]
    )

    if @user
      login_user!(@user)
    else
      @user = User.new
      flash.now[:errors] = ["Invalid user credentials!"]
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end
end
