class User < ApplicationRecord
    validates :firstname, :laststname, :is_admin, :business_name, :username, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, length: { minimum: 6 }, presence: true
end
