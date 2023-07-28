class CommentsController < ApplicationController
  def new
    @post = Post.find_by(params[:id])
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

  def destroy
    @comment = Comment.find_by(post_id: params[:post_id], id: params[:id])
    if @comment
      @comment.destroy
      redirect_to user_post_path(@comment), notice: 'Comment was successfully deleted.'
    else
      redirect_to user_post_path(@user, @post), alert: 'Comment not found'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:author_id, :post_id, :text)
  end
  # ...
end
