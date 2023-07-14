class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  validates :author_id, presence: true
  validates :title, presence: true
  validates :text, presence: true

  validates :title, length: { maximum: 255 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def posts_counter
    author.increment!(:post_counter)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
