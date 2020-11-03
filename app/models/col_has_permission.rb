class ColHasPermission < ApplicationRecord
  belongs_to :colaborator
  belongs_to :permission
end
