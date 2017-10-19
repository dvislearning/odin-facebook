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
  # Sends friend request.
  def friend_request(other_user)
    requesters << other_user
  end
  
end
