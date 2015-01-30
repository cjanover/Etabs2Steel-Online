class CreateAnalysisOptions < ActiveRecord::Migration
  def change
    create_table :analysis_options do |t|

      t.timestamps null: false
    end
  end
end
