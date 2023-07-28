# app/models/user.rb
class User < ApplicationRecord
  before_validation :set_default
        
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

        has_many :likes, foreign_key: :author_id, dependent: :destroy
        has_many :comments, foreign_key: :author_id, dependent: :destroy
        has_many :posts, foreign_key: :author_id, dependent: :destroy

        validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
        validates :name, :photo, :bio, presence: true

  def recent_posts
    posts.order(created_at: :asc).limit(3)
  end

  def set_default
    self.name ||= email.split('@')[0]
    self.posts_counter ||= 0
  end
end
