class FixThings < ActiveRecord::Migration
  def change
    add_column :profile, :active_name, :string
    add_column :default, :profile_id, :integer
    add_column :default, :name, :string
    
    delete_column :model_information, :user_id
    add_column :model_information, :default_id, :integer
    
    delete_column :convergence_option, :user_id
    add_column :convergence_option, :default_id, :integer
    
    delete_column :fiber_option, :user_id
    add_column :fiber_option, :default_id
    
    delete_column :vertical_constraint_option, :user_id
    add_column :vertical_constraint_option, :default_id
    
    delete_column :load_option, :user_id
    add_column :load_option, :default_id
    
    delete_column :material_model, :user_id
    add_colmn :material_model, :default_id
  end
end
