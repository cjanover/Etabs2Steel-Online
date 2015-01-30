class FixConvergenceOptions < ActiveRecord::Migration
  def change
    remove_column :Convergence_Options, :eec
    remove_column :Convergence_Options, :nsefbc
    remove_column :Convergence_Options, :nsefbr
    remove_column :Convergence_Options, :milf
    add_column :Convergence_Options, :mig, :integer
    add_column :Convergence_Options, :tol1, :float
    add_column :Convergence_Options, :tol3, :float
    add_column :Convergence_Options, :tol5, :float
    add_column :Convergence_Options, :tol7, :float
    add_column :Convergence_Options, :alphac, :float
    add_column :Convergence_Options, :a3, :float
  end
end
