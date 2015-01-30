class CreateLoadCombos < ActiveRecord::Migration
  def change
    create_table :load_combos do |t|
      t.integer :model_id
      t.string :case_name

      t.timestamps null: false
    end
  end
end
