class CreateMaterialModels < ActiveRecord::Migration
  def change
    create_table :material_models do |t|
      t.integer :user_id
      t.float :steelmat
      t.float :defwallshearmod
      t.float :concretemat
      t.string :materialconv1
      t.string :materialconv2
      t.string :materialconv3

      t.timestamps null: false
    end
  end
end
