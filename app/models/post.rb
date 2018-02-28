class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  after_save   :make_timeline_record  
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 5000 }
  
  private
  
    def make_timeline_record
      Timeline.create!(user_id: self.user.id, post_id: self.id)
    end
end
