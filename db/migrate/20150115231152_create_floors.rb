class CreateFloors < ActiveRecord::Migration
  def change
    create_table :floors do |t|
      t.integer :model_id
      t.string :name
      t.float :elevation

      t.timestamps null: false
    end
  end
end
