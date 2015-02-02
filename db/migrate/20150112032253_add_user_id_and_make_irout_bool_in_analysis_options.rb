class AddUserIdAndMakeIroutBoolInAnalysisOptions < ActiveRecord::Migration
  def change
    add_column :analysis_options, :user_id, :integer
    change_column :analysis_options, :irout, :boolean
  end
end
