class CreateLoadOptions < ActiveRecord::Migration
  def change
    create_table :load_options do |t|
      t.integer :user_id
      t.string :load_combo
      t.string :mass_combo
      t.float :gamult

      t.timestamps null: false
    end
  end
end
