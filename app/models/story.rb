class Story < ActiveRecord::Base
  belongs_to :iteration
has_many :tasks
  attr_accessible :Estimated_hours, :customer, :disposition, :name, :order, :priority, :status, :tracker, :Type, :description
end
