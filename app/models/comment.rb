class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  validates :user_id,  presence: true
  validates :content,  presence: true, length: { maximum: 5001 }
  
  # Over-rode this method to avoid generating comment controller.  Reconsider refactoring.
  def to_partial_path
    'posts/comment'
  end  
end
