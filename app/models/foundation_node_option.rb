class FoundationNodeOption < ActiveRecord::Base
  belongs_to :default
  has_many :foundation_nodes, dependent: :destroy
end
