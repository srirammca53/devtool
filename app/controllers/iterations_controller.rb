class IterationsController < ApplicationController
before_filter :test, :except => [:index, :new, :edit, :create]

def test
		@project = Project.find(params[:project_id])
		
		@iteration = @project.iteration.find(params[:id])
		
		@endtime =  @iteration.end_date - Time.now.to_date
		if @endtime.to_i >= -1
			@iteration.update_attributes(:status => "Closed")
			project_iterations_path(@project.id)
		 else
			project_iteration_path(@project.id, @iteration.id)
		 end
end

def index
    @project = Project.find(params[:project_id])
    @iterations = Iteration.find(:all)
end

def new
    @project = Project.find(params[:project_id])
    @iteration = @project.iteration.new
	 
end

def edit
    @project = Project.find(params[:project_id])
    @iteration = @project.iteration.find(params[:id])
end

def create
  @project = Project.find(params[:project_id])
    @all_iterations = Iteration.find(:all, :select => "status" ,:conditions => {:status => "Open", :project_id => @project.id}).map(&:status).count
   if  @iteration = @project.iteration.new(params[:iteration])
     @flag = 0
	if @iteration.status == "Open"
		if @all_iterations.to_i > 1
			flash[:error] = "One record is already \"Opened\""
			render :action => "new" and return
		 end
	
	else
		@current_iteration_start = @iteration.start_date
			@all_iterations_enddate = Iteration.find(:all, :select => "end_date" ,:conditions => {:project_id => @project.id}).map(&:end_date)
			@all_iterations_enddate.each do |enddate|
							if @current_iteration_start < enddate 
							@flag = @flag + 1
							end
						    end
							if @flag > 0 
							flash[:error] = "One of the iteration having the dates you selected select different one"
							end
	end
	

	end
  render :nothing => true
end

def update
   @project = Project.find(params[:project_id])
   @iteration = @project.iteration.find(params[:id])
		
   if @iteration.update_attributes(params[:iteration])
	if @iteration.status == "Closed"
		raise "yes ".inspect
	end
       render :action => "show"
   else
       render :action => "edit"
   end
 end

def show
    @project = Project.find(params[:project_id])
    @iteration = @project.iteration.find(params[:id])
    render :action => "show"
end
end
