require 'rails_helper'
require 'capybara/rspec'

RSpec.describe User, type: :feature do
  subject { User.new(name: 'John', post_counter: 3, photo: 'https://pic.com', bio: 'Project Owner') }
  before { subject.save }

  describe 'User show page' do
    before do
      # Create some posts for the user
      Post.create(author: subject, title: 'Hello', text: 'Hello World')
      Post.create(author: subject, title: 'World of tech', text: 'Technology is amazing')
      Post.create(author: subject, title: 'Coding is fun', text: 'I love coding')
      visit user_path(subject.id)
    end

    it "I can see the user's profile picture." do
      expect(page).to have_css('img')
    end

    it "I can see the user's username." do
      expect(page).to have_content(subject.name)
    end

    it 'I can see the number of posts the user has written.' do
      expect(page).to have_content('Number of Posts: 3')
    end

    it "I can see the user's bio." do
      visit user_path(subject.id)
      expect(page).to have_content(subject.bio)
    end

    it 'Displays the users first 3 posts.' do
      Post.create(author: subject, title: 'First Post', text: 'First post')
      visit user_path(subject.id)
      click_link 'See all Post'
      expect(page).to have_current_path(user_posts_path(subject))
    end

    it "I can see a button that lets me view all of a user's posts." do
      visit user_path(subject.id)
      expect(page).to have_link('See all Post', href: user_posts_path(subject))
    end

    it "When I click a user's post, it redirects me to that post's show page." do
      expect(page).to have_content('Number of Posts: 3')
    end

    it "When I click to see all posts, it redirects me to the user's post's index page." do
      Post.create(author: subject, title: 'First Post', text: 'First post')
      visit user_path(subject.id)
      click_link 'See all Post'
      expect(page).to have_current_path(user_posts_path(subject))
    end
  end
end
