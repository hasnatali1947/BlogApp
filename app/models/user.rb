# frozen_string_literal: true

# Represents a user of the blog application.
class User < ApplicationRecord
  has_many :comments
  has_many :posts
  has_many :likes
  validates :name, presence: true

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
