class UsersController < ApplicationController

  def index   # GET users_path

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
      # Handle a successful save.
    else
      render 'new'
    end
  end

  def edit    # GET edit_user_path(user)

  end

  def update  # PATCH user_path(user)

  end

  def destroy # DELETE user_path(user)

  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
