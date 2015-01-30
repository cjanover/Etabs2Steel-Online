class Default < ActiveRecord::Base
  belongs_to :config, polymorphic: true
  
  has_one :model_information, dependent: :destroy
  has_one :analysis_option, dependent: :destroy
  has_one :convergence_option, dependent: :destroy
  
  has_one :fiber_option, dependent: :destroy
  has_many :nsefbc_fiber, :through => :fiber_option
  has_many :nsefbr_fiber, :through => :fiber_option
  
  has_one :vertical_constraint_option, dependent: :destroy
  has_many :vertical_constraint, :through => :vertical_constraint_option
  
  has_one :load_option, dependent: :destroy
  
  has_one :response_time_history_option, dependent: :destroy
  has_many :extra_time_history, :through => :response_time_history_option
  
  has_one :material_model, dependent: :destroy
  
  has_one :foundation_node_option, dependent: :destroy
  has_many :foundation_nodes, :through => :foundation_node_option
end
