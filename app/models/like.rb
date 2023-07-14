class Like < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post

  validates :author_id, presence: true
  validates :post_id, presence: true

  after_create :increment_post_like_counter

  def increment_post_like_counter
    post.increment!(:likes_counter)
  end
end
