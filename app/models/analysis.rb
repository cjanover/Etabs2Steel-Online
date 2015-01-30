class Analysis < ActiveRecord::Base
  belongs_to :user
  
  has_one :default, as: :config, dependent: :destroy  
end
