class Timeline < ApplicationRecord
  validates :user_id, presence: true
  default_scope -> { order(created_at: :desc) }

  def timeline
    Timeline.where(user_id: id)
  end
  
  def self.delete_timeline(user, resource)
    timeline = Timeline.send(:where, "user_id": user.id, 
                  "#{resource.class.to_s.downcase}_id": resource.id)
    Timeline.destroy(timeline.first.id)
  end
end
