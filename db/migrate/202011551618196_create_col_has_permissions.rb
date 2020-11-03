class CreateColHasPermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :col_has_permissions do |t|
      t.references :colaborator, null: false, foreign_key: true
      t.references :permission, null: false, foreign_key: true

      t.timestamps
    end
  end
end
