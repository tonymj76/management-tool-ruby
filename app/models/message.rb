class Message < ApplicationRecord
  belongs_to :m_thread
  belongs_to :user
  belongs_to :message
end
