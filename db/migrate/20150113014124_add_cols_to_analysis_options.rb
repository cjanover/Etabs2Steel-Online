class AddColsToAnalysisOptions < ActiveRecord::Migration
  def change
    add_column :analysis_options, :debuglevel, :integer
    add_column :analysis_options, :sectionconversion, :boolean
    add_column :analysis_options, :matconversion, :boolean
  end
end
