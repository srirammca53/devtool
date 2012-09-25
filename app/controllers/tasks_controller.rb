class TasksController < ApplicationController


def index
  
  @project = Project.find(params[:project_id])
  @iteration = Iteration.find(params[:iteration_id])
  @story = Story.find(params[:story_id])
  @tasks = Task.find(:all)
	@logs = Log.find(:all)

if @iteration.status == "Closed"
	@tasks.each do |task|
		@story_id = Story.find(:all, :conditions=> {:id => task.story_id}) 
		@story_id.each do |story|
		@iteration = Iteration.find(:all , :conditions => {:id => story.iteration_id})
		@iteration.each do |it|
	     story.update_attribute("iteration_id" , 989)
             
			end
		end
	end
	end
end

def new
 @story = Story.find(params[:story_id])

  @task = @story.tasks.new

end

def create
    @projectid = Project.find(params[:project_id])
	 @iterationid = Iteration.find(params[:iteration_id])
      @storyid = Story.find(params[:story_id])
    @user = User.find(:all)
    @story = Story.find(params[:story_id])
    @task = @story.tasks.create(params[:task]) 
    @stid = @story.name
    @it = Iteration.find(:all , :conditions => {:id => @story.iteration_id }) 
    @it.each do |iname|  @iname = iname.name end 
	
	@user.each do |usr|
		if @task.acceptor == usr.lastname
		@usermail = usr
		
		end
        end 
	if @task.save
		@tid = @task.id
	 TaskMailer.task_creation(@usermail,@iname,@tid).deliver
	end
       #render :action => "show"
         	redirect_to project_iteration_story_task_path(@projectid.id, @iterationid.id, @storyid.id, @tid )

end

def edit
    @project = Project.find(params[:project_id])
    @iteration = @project.iteration.find(params[:iteration_id])
    @story = @iteration.story.find(params[:story_id])
    @task = @story.tasks.find(params[:id])
end
def completetask
	@task_id = Task.find(params[:id])
    @task_id.story_id #story id
    @storyid = Story.find(:all, :conditions => {:id => @task_id.story_id })
    @storyid.each do |iterationid|
		@itid = iterationid.iteration_id#iteration id
    end
    @pid = Iteration.find(:all, :conditions => {:id => @itid })
    @pid.each do |projectid|
    @proejctid = projectid.project_id #project id
    end
	@task_id.update_attribute("status", true)
	redirect_to  project_iteration_story_tasks_path( @proejctid , @itid , @task_id.story_id , @task_id.id)
end

def reopen
	@task_id = Task.find(params[:id])
    @task_id.story_id #story id
    @storyid = Story.find(:all, :conditions => {:id => @task_id.story_id })
    @storyid.each do |iterationid|
		@itid = iterationid.iteration_id#iteration id
    end
    @pid = Iteration.find(:all, :conditions => {:id => @itid })
    @pid.each do |projectid|
    @proejctid = projectid.project_id #project id
    end
	@task_id.update_attribute("status", false)
	redirect_to  project_iteration_story_tasks_path( @proejctid , @itid , @task_id.story_id , @task_id.id)
end

def issue
	raise "yes".inspect
end

def update
    @project = Project.find(params[:project_id])
    @iteration = @project.iteration.find(params[:iteration_id])
    @story = @iteration.story.find(params[:story_id])
    @task = @story.tasks.find(params[:id])
    @task.update_attributes(params[:task])
    redirect_to project_iteration_story_task_path(@project.id, @iteration.id, @story.id, @task.id )

end



def delete
   raise "demo".inspect
end

def log
 redirect_to :controller=> :logs, :action => :new
 render :layout => false
end



def show
 @pro = Project.find(params[:project_id])
 @iteration = Iteration.find(params[:iteration_id]) 
 @story = Story.find(params[:story_id])
 @task = Task.find(params[:id]) 
end

def update_tasks
	
	raise "yes".inspect
end

def logs
     params[:spent_hours].each do |t,values|
		@task = Task.find(t)
		@values = values 
		@spent = @values.values[0]
		@desc = @values.values[1]
		@date = params["gettingdate"]
		
			if @spent != "" 

				@log = @task.logs.create(:spent_hours => @spent , :description => @desc, :report_date => @date )
			end
	 end
redirect_to myprojects_path
end

end
