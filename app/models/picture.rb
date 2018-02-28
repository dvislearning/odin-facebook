class Picture < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true 
  after_save   :make_timeline_record   
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  validates_attachment_file_name :image, :matches => [/png\Z/, /jpe?g\Z/, /gif\Z/]
  
  private
  
    def make_timeline_record
      Timeline.create!(user_id: self.user.id, picture_id: self.id)
    end
end
