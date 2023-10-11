require 'rails_helper'

RSpec.describe 'Users', type: :system, js: true do
  before(:all) do
    @obama = User.create(name: 'Barack Obama', photo: 'https://images1.penguinrandomhouse.com/author/22627',
                         bio: '44th President of the United States')

    @meryl = User.create(name: 'Meryl Streep', photo: '/assets/default_user.png',
                         bio: 'Academy Award-winning actress')

    @post1 = Post.create(title: 'State of the Union', text: 'Reflecting on the state of our nation.', author: @obama)
    @post2 = Post.create(title: 'Leadership in Hollywood', text: 'Dedicated to my craft and the art of acting.',
                         author: @meryl)
    @post3 = Post.create(title: 'Policy and Change', text: 'Working to make the world a better place.', author: @obama)
    @post4 = Post.create(title: 'Iconic Performances', text: 'Exploring the roles that define my career.',
                         author: @meryl)
  end

  describe 'index page' do
    before(:example) do
      visit users_path
    end

    it 'should render user information' do
      expect(page).to have_content(@obama.name)
      expect(page).to have_content(@meryl.name)

      expect(page).to have_css("img[src*='https://images1.penguinrandomhouse.com/author/22627']")
      expect(page).to have_css("img[src*='default_user.png']")

      expect(page).to have_content(@obama.postsCounter)
      expect(page).to have_content(@meryl.postsCounter)
    end

    it 'should redirect to the user page when a username is clicked' do
      find('.user_card', text: @obama.name).click
      expect(page).to have_current_path(user_path(@obama))
    end
  end
end
