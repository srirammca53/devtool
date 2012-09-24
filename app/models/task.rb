class Task < ActiveRecord::Base
  belongs_to :story 
  belongs_to :issue
  has_many :logs
  attr_accessible :acceptor, :description, :disposition, :estimated_hours, :name, :task_type,:story_id

end
