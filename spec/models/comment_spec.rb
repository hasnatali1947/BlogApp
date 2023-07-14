require 'rails_helper'

RSpec.describe Comment, type: :model do
  user = User.new(name: 'Hasnat', photo: 'profile_picture', bio: 'User 1 called', posts_counter: 0)
  post = Post.new(author_id: user, title: 'Eat me', text: 'You can fry and eat')

  subject { Comment.new(author_id: user, post_id: post, text: 'Nice buddy') }
  before { subject.save }

  it 'should belong to an author' do
    comment = Comment.reflect_on_association(:user)
    expect(comment.macro).to eq(:belongs_to)
  end

  it 'should belong to a post' do
    comment = Comment.reflect_on_association(:post)
    expect(comment.macro).to eq(:belongs_to)
  end

  it 'checking comment<' do
    user1 = User.new(name: 'Hasnat', photo: 'profile_picture', bio: 'User 1 called', posts_counter: 0)
    post1 = Post.new(author_id: user, title: 'Eat me', text: 'You can fry and eat')
    comment = Comment.new(author_id: user1, post_id: post1, text: 'Nice')

    expect(comment.text).to eq('Nice')
  end
end
