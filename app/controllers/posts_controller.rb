class PostsController < ApplicationController
  before_action :set_user

  rescue_from ActiveRecord::RecordNotFound, with: :post_not_found

  def index
    @posts = @user.posts
  end

  def show
    @post = @user.posts.find(params[:id])
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def post_not_found
    flash[:alert] = 'Post not found'
    redirect_to user_posts_path(@user)
  end
end
