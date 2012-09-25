class BacklogsController < ApplicationController

def index
	@stories = Story.find(:all , :conditions => {:iteration_id => 989 })
	render :action => "index"
end

def new
@backlog = Backlogs.find(989)
@task = Task.new

#@task = @backlog.tasks.new
raise @task.inspect
end
def assign
@tasks = params[:tasks]
@iteration = params[:name]
@tasks.each do |task|
raise task.inspect
end

end
end
