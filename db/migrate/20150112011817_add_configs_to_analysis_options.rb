class AddConfigsToAnalysisOptions < ActiveRecord::Migration
  def change
    add_column :Analysis_Options, :panel_zone_rigidity, :boolean
    add_column :Analysis_Options, :mtp, :integer
    add_column :Analysis_Options, :nss, :integer
    add_column :Analysis_Options, :beta, :float
    add_column :Analysis_Options, :gamma, :float
    add_column :Analysis_Options, :a0, :float
    add_column :Analysis_Options, :first_mode_period, :float
    add_column :Analysis_Options, :damping_ratio_stiffness, :float
    add_column :Analysis_Options, :damping_ratio_column, :float
    add_column :Analysis_Options, :base_shear_percent, :float
    add_column :Analysis_Options, :base_shear, :float
    add_column :Analysis_Options, :r, :float
    add_column :Analysis_Options, :base_drift, :float
    add_column :Analysis_Options, :dt, :float
    add_column :Analysis_Options, :irint, :float
    add_column :Analysis_Options, :irout, :float
    add_column :Analysis_Options, :istop, :float
  end
end
