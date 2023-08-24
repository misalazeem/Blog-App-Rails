class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = params[:user_id]
    @comment.post_id = params[:post_id]
    @post = Post.find(params[:post_id])

    if @comment.save
      redirect_to user_post_path(id: @post.id, user_id: @post.author_id)
    else
      render :new, alert: 'ERROR! something went wrong'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
