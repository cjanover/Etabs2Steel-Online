class Profile < ActiveRecord::Base
  #Dependencies
  belongs_to :user
  
  has_many :defaults, as: :config, dependent: :destroy  
end
