class AddUserIdAndMakeIroutBoolInAnalysisOptions < ActiveRecord::Migration
  def change
    add_column :Analysis_Options, :user_id, :integer
    change_column :Analysis_Options, :irout, :boolean
  end
end
