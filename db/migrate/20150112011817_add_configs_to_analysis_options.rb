class AddConfigsToAnalysisOptions < ActiveRecord::Migration
  def change
    add_column :analysis_options, :panel_zone_rigidity, :boolean
    add_column :analysis_options, :mtp, :integer
    add_column :analysis_options, :nss, :integer
    add_column :analysis_options, :beta, :float
    add_column :analysis_options, :gamma, :float
    add_column :analysis_options, :a0, :float
    add_column :analysis_options, :first_mode_period, :float
    add_column :analysis_options, :damping_ratio_stiffness, :float
    add_column :analysis_options, :damping_ratio_column, :float
    add_column :analysis_options, :base_shear_percent, :float
    add_column :analysis_options, :base_shear, :float
    add_column :analysis_options, :r, :float
    add_column :analysis_options, :base_drift, :float
    add_column :analysis_options, :dt, :float
    add_column :analysis_options, :irint, :float
    add_column :analysis_options, :irout, :float
    add_column :analysis_options, :istop, :float
  end
end
