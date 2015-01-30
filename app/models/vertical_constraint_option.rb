class VerticalConstraintOption < ActiveRecord::Base
  belongs_to :default
  has_many :vertical_constraint, dependent: :destroy
end
