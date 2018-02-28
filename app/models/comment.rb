class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  validates :user_id,  presence: true
  validates :content,  presence: true, length: { maximum: 5001 }
  validates :commentable_id,  presence: true
  validates :commentable_type,  presence: true
end
