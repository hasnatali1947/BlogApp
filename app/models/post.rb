class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  validates :author_id, presence: true
  validates :title, presence: true
  validates :text, presence: true

  def posts_counter
    author.increment!(:post_counter)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
