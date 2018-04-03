class UsersController < ApplicationController

  def index   # GET users_path

  end

  def show    # GET user_path(user)
    @user = User.find(params[:id])
  end

  def new     # GET new_user_path
  end

  def create  # POST users_path

  end

  def edit    # GET edit_user_path(user)

  end

  def update  # PATCH user_path(user)

  end

  def destroy # DELETE user_path(user)

  end
end
