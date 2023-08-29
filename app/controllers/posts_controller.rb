class PostsController < ApplicationController
  before_action :find_user, only: %i[index show like unlike]
  before_action :find_post, only: %i[show like unlike]

  rescue_from ActiveRecord::RecordNotFound, with: :post_not_found

  def index
    @posts = @user.posts.includes(:author)
    @posts = @user.posts.includes(:comments)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    if @post.save
      redirect_to user_posts_path(id: @post.author_id)
    else
      render :new, alert: 'Error! something went wrong'
    end
  end

  def like
    @like = @post.likes.new
    @like.author = current_user
    @like.save
    redirect_to user_post_path(@user, @post)
  end

  def unlike
    @like = @post.likes.find_by(post: @post)
    @like&.destroy
    redirect_to user_post_path(@user, @post)
  end

  def show
    @post = @user.posts.includes(:author, :comments, :likes).find(params[:id])
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_post
    @post = @user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def post_not_found
    flash[:alert] = 'Post not found'
    redirect_to user_posts_path(@user)
  end
end
