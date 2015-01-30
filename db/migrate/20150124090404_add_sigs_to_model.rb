class AddSigsToModel < ActiveRecord::Migration
  def change
    add_column :material_models, :mat_1_SIGU, :float
    add_column :material_models, :mat_2_SIGU, :float
  end
end
