class FixAnalysisOptionTypes < ActiveRecord::Migration
  def change
    change_column :analysis_options, :panel_zone_rigidity, :integer
  end
end
