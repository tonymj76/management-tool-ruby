# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.0]
  
  def change
    create_table :users do |t|
      t.string :first_name, null: false, default: ""
      t.string :last_name, null: false, default: ""
      t.string :email, null: false, default: ""
      t.boolean :is_admin, null: true, default: false
      t.string :password, null: false, default: ""
      t.string :password_digest, null: true, default: ""
      t.timestamps null: false
    end

    add_index :users, :email, unique: true
  end
end
