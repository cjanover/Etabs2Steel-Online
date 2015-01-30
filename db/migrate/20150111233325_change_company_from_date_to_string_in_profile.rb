class ChangeCompanyFromDateToStringInProfile < ActiveRecord::Migration
  def change
    change_column :Profiles, :company, :string
  end
end
