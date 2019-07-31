class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def index   # GET users_path
    # todo: adjust this method
    @users = User.paginate(page: params[:page])
  end

  def show    # GET user_path(user)
    @user = User.find(params[:id])
  end

  def new     # GET new_user_path
    @user = User.new
  end

  def create  # POST users_path
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user # == redirect_to user_url(@user)
    else
      render 'new'
    end
  end

  def edit    # GET edit_user_path(user)
  end

  def update  # PATCH user_path(user)
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy # DELETE user_path(user)

  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # Before filters

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
