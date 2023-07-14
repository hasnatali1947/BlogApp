require 'rails_helper'

RSpec.describe Like, type: :model do
  user = User.new(name: 'Hasnat', photo: 'profile_picture', bio: 'User 1', posts_counter: 0)
  post = Post.new(author_id: user, title: 'Eat me', text: 'You can fry and eat')

  subject { Like.new(author_id: user, post_id: post) }
  before { subject.save }

  it 'should belong to an author' do
    like = Like.reflect_on_association(:user)
    expect(like.macro).to eq(:belongs_to)
  end

  it 'should belong to a post' do
    like = Like.reflect_on_association(:post)
    expect(like.macro).to eq(:belongs_to)
  end
end
