json.extract! user, :id, :firstname, :lastname, :username, :email, :business_name, :password, :is_admin, :created_at, :updated_at
json.url user_url(user, format: :json)
