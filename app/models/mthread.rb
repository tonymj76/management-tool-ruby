class Mthread < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :messages
end
