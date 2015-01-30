class ResponseTimeHistoryOption < ActiveRecord::Base
  belongs_to :default
  has_many :extra_time_histories, dependent: :destroy
end
