class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :recoverable, :trackable, 
  # :validatable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable
  validates :email, presence: true, length: { maximum: 255 },
                    uniqueness: { case_sensitive: false }
  validates :username,  presence: true, length: { maximum: 50 }
  has_many :friend_requests, class_name:  "Relationship",
                                  foreign_key: "requester_id",
                                  dependent:   :destroy
  has_many :receivers, dependent: :destroy  
end
