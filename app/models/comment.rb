# frozen_string_literal: true

# Represents a comment made by a user on a post.
class Comment < ApplicationRecord
  belongs_to :user, foreign_key: 'author_id'
  belongs_to :post

  validates :author_id, presence: true
  validates :post_id, presence: true
  validates :text, presence: true

  after_create :increment_post_comment_counter

  def increment_post_comment_counter
    post.increment!(:comments_counter)
  end
end
