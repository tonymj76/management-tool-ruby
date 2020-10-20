class User < ApplicationRecord
  has_secure_password validations: false
  has_many :colaborators
  has_many :projects, through: :colaborators
  has_many :messages
  has_many :m_threads
  before_save { self.email = email.downcase }

  validates :first_name, presence: true
  validates :last_name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, :if => :password
  
  def author(id)
    return "You" if self.id == id
    user = User.find(id)
    return user.first_name + " " + user.last_name
  end
  
end
