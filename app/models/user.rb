class User < ApplicationRecord
  before_save :to_lower_case
  has_many :appointments, dependent: :destroy
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates_presence_of :email, :city, :username
  validates :email, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :username, length: {in: 3..16}, uniqueness: { case_sensitive: false }
  
  private

    def to_lower_case
      self.email = email.downcase
      self.username = username.downcase
    end
end
