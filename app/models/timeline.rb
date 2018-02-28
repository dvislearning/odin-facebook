class Timeline < ApplicationRecord
  validates :user_id, presence: true
  default_scope -> { order(created_at: :desc) }

  def timeline
    Timeline.where(user_id: id)
  end
end
