require 'rails_helper'

RSpec.describe 'User posts', type: :system, js: true do
  before(:all) do
    @biden = User.create(name: 'Joe Biden', photo: 'https://www.whitehouse.gov/wp-content/uploads/2021/04/P20210303AS-1901-cropped.jpg',
                         bio: 'President of the United States.')
    @trump = User.create(name: 'Donald Trump', photo: '/assets/default_user.png',
                         bio: 'Former President of the United States.')

    @biden_post1 = Post.create(title: 'State of the Nation', text: 'Addressing the current state of the nation.',
                               author: @biden)
    @biden_post2 = Post.create(title: 'Foreign Policy Update', text: 'Discussing recent foreign policy developments.',
                               author: @biden)

    @trump_post1 = Post.create(title: 'America First', text: 'Highlighting the "America First" agenda.',
                               author: @trump)
    @trump_post2 = Post.create(title: 'Economic Policies', text: 'Talking about economic policies and achievements.',
                               author: @trump)

    @comment1 = Comment.create(text: 'Great speech, Mr. President!', author: @trump, post: @biden_post1)
    @comment2 = Comment.create(text: 'I have some reservations about this.', author: @biden, post: @biden_post1)
    @comment3 = Comment.create(text: 'How do you plan to address this issue?', author: @trump, post: @biden_post1)
    @comment4 = Comment.create(text: 'I believe we need bipartisan cooperation.', author: @biden, post: @biden_post1)
    @comment5 = Comment.create(text: 'Looking back on my term.', author: @trump, post: @trump_post1)
    @comment6 = Comment.create(text: 'The economy has improved significantly.', author: @trump, post: @trump_post1)
    @comment7 = Comment.create(text: 'Let\'s discuss foreign policy.', author: @biden, post: @biden_post2)
  end

  describe 'show page' do
    before(:example) do
      visit user_post_path(@biden, @biden_post1)
    end

    it 'should render a user\'s post information' do
      expect(page).to have_content(@biden_post1.title.capitalize)
      expect(page).to have_content("by #{@biden.name}")
      expect(page).to_not have_content('Comments: 7 | Likes: 0')
      expect(page).to have_content(@biden_post1.text)

      # The username and text of each comment
      @biden_post1.comments.each do |comment|
        expect(page).to have_content(comment.author.name)
        expect(page).to have_content(comment.text)
      end
    end
  end
end
