class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :recoverable, :trackable, 
  # :validatable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable
  validates :email, presence: true, length: { maximum: 255 },
                    uniqueness: { case_sensitive: false }
  validates :username,  presence: true, length: { maximum: 50 }         
end
