class AddColumnsToMaterialModel < ActiveRecord::Migration
  def change
    remove_column :material_models, :steelmat
    remove_column :material_models, :concretemat
    
    add_column :material_models, :steelmat_G, :float
    add_column :material_models, :steelmat_Sy, :float
    
    add_column :material_models, :mat_1_E, :float
    add_column :material_models, :mat_1_ES, :float
    add_column :material_models, :mat_1_SIGY, :float
    add_column :material_models, :mat_1_EPSS, :float
    add_column :material_models, :mat_1_EPSU, :float
    add_column :material_models, :mat_1_PRAT, :float
    add_column :material_models, :mat_1_RES, :float
    
    add_column :material_models, :mat_2_E, :float
    add_column :material_models, :mat_2_ES, :float
    add_column :material_models, :mat_2_SIGY, :float
    add_column :material_models, :mat_2_EPSS, :float
    add_column :material_models, :mat_2_EPSU, :float
    add_column :material_models, :mat_2_PRAT, :float
    add_column :material_models, :mat_2_RES, :float
    
    add_column :material_models, :concretemat_E, :float
    add_column :material_models, :concretemat_CS, :float
    add_column :material_models, :concretemat_PCT, :float
  end
end
