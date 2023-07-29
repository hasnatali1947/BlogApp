class CommentsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  belongs_to :user
  belongs_to :post

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.build(comment_params)
    @post = Post.find(params[:post_id])

    if @comment.save
      redirect_to user_post_path(@post.author, @post), notice: 'Comment created successfully!'
    else
      render 'new'
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:comment_del])
    if @comment
      @comment.destroy
      redirect_to "/users/#{params[:user_id]}/posts/#{params[:id]}", notice: 'Your comment is deleted!'
    else
      redirect_to "/users/#{params[:user_id]}/posts/#{params[:id]}", alert: 'Comment not found!'
    end
  end



  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  # ...
end
