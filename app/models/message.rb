class Message < ApplicationRecord
  belongs_to :mthread
  belongs_to :user
  has_many :messages, foreign_key: "message_id", :dependent => :delete_all
end
