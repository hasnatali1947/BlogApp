class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.build(comment_params)
    @current_post = Post.find(params[:post_id])
    @post = Post.find(params[:comment][:post_id])
    if @comment.save
      redirect_to user_post_path(@post.author, @post)
      @comment.increment_post_comment_counter
    else
      render 'new'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:author_id, :post_id, :text)
  end
  # ...
end
