require 'rails_helper'

describe Comment, type: :model do
  let(:user) { User.create(name: 'Jake', photo: 'user.png', bio: 'Jake is a 21-year-old footballer from Ghana') }
  let(:post1) { Post.create(author: user, title: 'My first post', text: 'Ghana is in West Africa') }

  describe 'Associations' do
    it 'belongs to an author' do
      association = described_class.reflect_on_association(:author)
      expect(association.macro).to eq(:belongs_to)
      expect(association.class_name).to eq('User')
    end

    it 'belongs to a post' do
      association = described_class.reflect_on_association(:post)
      expect(association.macro).to eq(:belongs_to)
      expect(association.class_name).to eq('Post')
    end
  end

  it 'checking comment<' do
    user1 = User.new(name: 'Hasnat', photo: 'profile_picture', bio: 'User 1 called', posts_counter: 0)
    post1 = Post.new(author_id: user, title: 'Eat me', text: 'You can fry and eat')
    comment = Comment.new(author_id: user1, post_id: post1, text: 'Nice')

    expect(comment.text).to eq('Nice')
  end
end
