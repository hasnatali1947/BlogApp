class Api::PostsController < ActionController::Base
  def index
    user_id = params[:user_id] # Assuming the user ID is sent as a parameter in the request
    @posts = Post.includes(:comments).where(author_id: user_id)
    render json: @posts
  end
end
