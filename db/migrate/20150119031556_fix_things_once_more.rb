class FixThingsOnceMore < ActiveRecord::Migration
  def change
    add_column :nodes, :X, :float
    add_column :nodes, :Y, :float
    add_column :nodes, :Z, :float
    
    add_column :analysis_options, :ndim, :float
    
  end
end
