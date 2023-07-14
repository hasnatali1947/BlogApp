require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(name: 'Hasnat', photo: 'profile_picture', bio: 'User 1', posts_counter: 0)
  end

  before { subject.save }
  it 'User should be valid !not_empty' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'valid post counter INT' do
    subject.posts_counter = 'nuh'
    expect(subject).to_not be_valid
  end

  it 'post counter should be equal or greater than 0' do
    subject.posts_counter = -67
    expect(subject).to_not be_valid
  end

  it 'valid Bio' do
    subject.bio = nil
    expect(subject).to_not be_valid
  end

  it 'valid link' do
    subject.photo = nil
    expect(subject).to_not be_valid
  end
end
