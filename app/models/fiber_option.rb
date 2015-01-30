class FiberOption < ActiveRecord::Base
  belongs_to :default
  has_many :nsefbc_fibers, dependent: :destroy
  has_many :nsefbr_fibers, dependent: :destroy
end
