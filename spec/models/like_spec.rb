require 'rails_helper'

describe Like, type: :model do
  let(:user) { User.create(name: 'Jake', photo: 'user.png', bio: 'Jake is a 21-year-old footballer from Ghana') }
  let(:post) { Post.create(author: user, title: 'My first post', text: 'Ghana is in West Africa') }

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

  it 'should belong to a post' do
    like = Like.reflect_on_association(:post)
    expect(like.macro).to eq(:belongs_to)
  end
end
