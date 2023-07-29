class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @posts = Post.where(author_id: params[:user_id]).includes(:comments)
    @user = User.find(params[:user_id])
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

  def destroy
    @post = Post.find_by_id(params[:id])
    @post.likes.destroy_all
    @post.comments.destroy_all
    @post.destroy

    respond_to do |format|
      format.html { redirect_to "/users/#{params[:user_id]}/posts", notice: 'Post has been destroyed!' }
      format.json { head :no_content }
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
