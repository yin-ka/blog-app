require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:user) { User.create(name: 'User Name') }
  let!(:post) { Post.create(title: 'Post Title', author: user) }

  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should belong_to(:post).class_name('Post') }
  end

  describe '#increment_comments_count' do
    it 'should increment the comments_counter of the associated post' do
      comment = Comment.create(author: user, post:)

      expect do
        comment.send(:increment_comments_count)
        post.reload
      end.to change { post.comments_counter }.by(1)
    end
  end
end
