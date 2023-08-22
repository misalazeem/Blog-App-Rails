class UsersController < ApplicationController
  before_action :find_user, only: [:show]
  rescue_from ActiveRecord::RecordNotFound, with: :user_not_found
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new; end

  def find_user
    @users = User.find(params[:id])
  end

  def user_not_found
    flash[:alert] = "User not found"
    redirect_to users_path
  end

end
