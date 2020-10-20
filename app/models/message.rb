class Message < ApplicationRecord
  belongs_to :mthread
  belongs_to :user
  belongs_to :message
end
