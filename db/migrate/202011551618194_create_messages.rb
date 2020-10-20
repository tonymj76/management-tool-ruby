class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.text :content
      t.references :mthread, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :message, null: true, foreign_key: true

      t.timestamps
    end
  end
end
