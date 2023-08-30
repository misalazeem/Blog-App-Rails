class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :find_user, only: [:show]
  rescue_from ActiveRecord::RecordNotFound, with: :user_not_found

  def index
    @users = User.all
  end

  def show
    @three_recent_posts = @user.recent_three unless @user.nil?
  end

  def new; end

  def find_user
    @user = User.find(params[:id])
  end

  def user_not_found
    flash[:alert] = 'User not found'
    redirect_to users_path
  end
end
