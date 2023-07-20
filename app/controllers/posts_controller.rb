class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
    @comments = Comment.where(post_id: @posts.pluck(:id)).includes(:user)
  end

  def show
    @post = Post.find(params[:id])
    @comments = Comment.where(post_id: @post.id).includes(:user)
    @users = User.all
    @user = @post.author
  end
end
