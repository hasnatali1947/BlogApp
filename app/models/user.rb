# app/models/user.rb
class User < ApplicationRecord
  before_validation :set_default

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :posts, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id
  has_many :likes, foreign_key: :author_id

  validates :name, :photo, :bio, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  private

  def set_default
    self.name ||= email.split('@')[0]
    self.posts_counter ||= 0
  end
end
