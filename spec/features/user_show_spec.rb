require 'rails_helper'

RSpec.describe 'Users', type: :system, js: true do
  before(:all) do
    @obama = User.create(name: 'Barack Obama', photo: 'https://images1.penguinrandomhouse.com/author/22627',
                         bio: '44th President of the United States')

    @streep = User.create(name: 'Meryl Streep', photo: '/assets/default_user.png',
                          bio: 'Academy Award-winning actress')

    @post1 = Post.create(title: 'Presidential Achievements', text: 'Reflecting on my time in office.', author: @obama)
    @post2 = Post.create(title: 'The Art of Acting', text: 'Dedicated to my craft and the art of acting.',
                         author: @streep)
    @post3 = Post.create(title: 'Working for Change', text: 'Striving to make a positive impact on the world.',
                         author: @obama)
    @post4 = Post.create(title: 'Iconic Movie Roles', text: 'Exploring the memorable characters I\'ve portrayed.',
                         author: @streep)
  end

  describe 'show page' do
    before(:example) do
      visit user_path(@obama)
    end

    it 'shows the user profile information' do
      expect(page).to have_css("img[src*='https://images1.penguinrandomhouse.com/author/22627']")
      expect(page).to have_content(@obama.name)
      expect(page).to have_content('Posts: 2') # Adjust the post count as needed
      expect(page).to have_content(@obama.bio)

      # shows the user's 3 most recent posts
      @obama.most_recent_three_posts.each do |post|
        expect(page).to have_content(post.title.capitalize)
        expect(page).to have_content(post.text)
      end

      # shows a button to view all posts
      expect(page).to have_link('See all posts', href: user_posts_path(@obama))
    end

    it 'redirects to post show page when clicking on a post title' do
      click_link @post1.title.capitalize
      expect(page).to have_current_path(user_post_path(@obama, @post1))
    end

    it 'redirects to user posts index page when clicking on view all posts button' do
      click_link 'See all posts'
      expect(page).to have_current_path(user_posts_path(@obama))
    end
  end
end
