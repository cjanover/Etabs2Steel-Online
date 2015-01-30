class FixAgain < ActiveRecord::Migration
  def change
    add_column :profiles, :active_name, :string
    add_column :defaults, :profile_id, :integer
    add_column :defaults, :name, :string
    
    remove_column :model_informations, :user_id
    add_column :model_informations, :default_id, :integer
    
    remove_column :convergence_options, :user_id
    add_column :convergence_options, :default_id, :integer
    
    remove_column :fiber_options, :user_id
    add_column :fiber_options, :default_id, :integer
    
    remove_column :vertical_constraint_options, :user_id
    add_column :vertical_constraint_options, :default_id, :integer
    
    remove_column :load_options, :user_id
    add_column :load_options, :default_id, :integer
    
    remove_column :material_models, :user_id
    add_column :material_models, :default_id, :integer
    
  end
end
