class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :recoverable, :trackable, 
  # :validatable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable
  validates :email, presence: true, length: { maximum: 255 },
                    uniqueness: { case_sensitive: false }
  validates :username,  presence: true, length: { maximum: 50 }

  has_many :sent_requests, class_name:  "Relationship",
                                  foreign_key: "requester_id",
                                  dependent:   :destroy
  has_many :received_requests, class_name:  "Relationship",
                                   foreign_key: "receiver_id",
                                   dependent:   :destroy


  # finds relationship between two users
  def find_relationship(other_user)
    requested_friend =  Relationship.where(requester_id: self.id).where(receiver_id: other_user.id)
    requested_friend.any? ? requested_friend : Relationship.where(requester_id: other_user.id).where(receiver_id: self.id)
  end
  
  # checks to see if user has pending friend requests
  def has_pending_requests?
    received_requests.any?
  end
end
