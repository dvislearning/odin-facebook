class Relationship < ApplicationRecord
  belongs_to :requester, class_name: "User"
  belongs_to :receiver, class_name: "User"
  scope :pending, -> { where(confirmed_friends: false) }   
end
