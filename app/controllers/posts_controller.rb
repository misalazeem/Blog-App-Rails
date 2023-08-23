class PostsController < ApplicationController
  before_action :find_user, only: %i[index show]
  before_action :find_post, only: [:show]

  rescue_from ActiveRecord::RecordNotFound, with: :post_not_found

  def index
    @posts = @user.posts
  end

  def show
    @post = @user.posts.find(params[:id])
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_post
    @post = @user.posts.find(params[:id])
  end

  def post_not_found
    flash[:alert] = 'Post not found'
    redirect_to user_posts_path(@user)
  end
end
