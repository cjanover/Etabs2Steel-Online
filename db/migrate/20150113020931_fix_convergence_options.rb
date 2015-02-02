class FixConvergenceOptions < ActiveRecord::Migration
  def change
    remove_column :convergence_options, :eec
    remove_column :convergence_options, :nsefbc
    remove_column :convergence_options, :nsefbr
    remove_column :convergence_options, :milf
    add_column :convergence_options, :mig, :integer
    add_column :convergence_options, :tol1, :float
    add_column :convergence_options, :tol3, :float
    add_column :convergence_options, :tol5, :float
    add_column :convergence_options, :tol7, :float
    add_column :convergence_options, :alphac, :float
    add_column :convergence_options, :a3, :float
  end
end
