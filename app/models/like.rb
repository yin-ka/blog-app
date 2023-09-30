# app/models/like.rb
class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post, class_name: 'Post'
  after_save :increment_likes_count

  private

  def increment_likes_count
    return unless new_record? || saved_change_to_attribute?(:post_id)

    post.increment!(:likes_counter)
  end
end
