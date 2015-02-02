class ChangeCompanyFromDateToStringInProfile < ActiveRecord::Migration
  def change
    change_column :profiles, :company, :string
  end
end
