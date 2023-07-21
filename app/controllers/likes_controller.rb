class LikesController < ApplicationController
    def create
      @user = User.find(params[:user_id])
      @post = Post.find(params[:post_id])
      @like = Like.new(user: @user, post: @post)
      if @like.save
        @post.update_column(:likes_counter, @post.likes.count)
        redirect_to user_post_path(@user, @post)
      else
        puts @post.error.message
      end
    end
  end
