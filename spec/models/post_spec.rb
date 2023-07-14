require 'rails_helper'

RSpec.describe Post, type: :model do
  user = User.new(name: 'Hasnat', photo: 'link', bio: 'User 1', posts_counter: 0)
  subject do
    Post.new(author_id: user, title: 'Eat me', text: 'You can fry and eat')
  end

  before { subject.save }

  it 'title should be valid' do
    subject.title = nil
    expect(subject).to_not be_valid
  end
  it 'Comments counter should be positive' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end
  it 'likes counter should be positive' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end
  it 'author should be valid' do
    subject.author_id = nil
    expect(subject).to_not be_valid
  end
end
