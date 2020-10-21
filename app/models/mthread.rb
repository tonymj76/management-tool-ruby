class Mthread < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :messages, :dependent => :delete_all

  def owner
    user = User.find(self.user_id)
    return "#{user.first_name}+#{user.last_name}"
  end

  def owner_formatted
    user = User.find(self.user_id)
    return user.first_name + " " + user.last_name
  end
  
end
