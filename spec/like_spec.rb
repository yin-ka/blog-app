require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'example_user') }
  let(:post) { Post.create(title: 'Example Post', author: user, likes_counter: 0) }
  let(:like) { Like.create(author: user, post:) }

  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should belong_to(:post).class_name('Post') }
  end

  describe 'after_save callback' do
    it 'should increment the likes_counter on the associated post' do
      expect do
        like.save
        post.reload
      end.to change { post.likes_counter }.by(1)
    end

    it 'should not increment the likes_counter if the like is already persisted' do
      like.save
      expect do
        like.save
        post.reload
      end.not_to(change { post.likes_counter })
    end
  end
end
