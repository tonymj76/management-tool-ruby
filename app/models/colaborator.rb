class Colaborator < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :col_has_permissions
end
