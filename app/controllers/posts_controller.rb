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

  def new 
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to user_post_path(current_user, @post)
    else
      puts @post.errors.full_messages
      render 'new'
    end
  end

  private

  def post_params
    params.require(:post).permit(:author_id, :title, :text, :comments_counter, :likes_counter)
  end

end
