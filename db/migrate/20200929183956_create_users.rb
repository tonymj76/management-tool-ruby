class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :username
      t.string :email
      t.string :business_name
      t.string :password
      t.boolean :is_admin
      t.timestamps
    end
  end
end
