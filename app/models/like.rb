class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create :increment_post_like_counter

  def increment_post_like_counter
    post.increment!(:likes_counter)
  end
end
