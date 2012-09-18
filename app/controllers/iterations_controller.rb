class IterationsController < ApplicationController
#before_filter :test, :except => [:index, :new, :edit, :show]

def test
		@project = Project.find(params[:project_id])		
		@new_params = params[:iteration]
		raise @new_params.each_value { |key| puts "#{key}" }.inspect
			flag = 0
			@project.iteration.each do |it|
					@endd = it.end_date
					if @enddate < @endd
						flag += 1
					 else
						flag = 0
					 end
			end
			if flag == 0
					       redirect_to  "create"
				else
						raise "you selecting date is already there".inspect
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
     @iteration = @project.iteration.new(params[:iteration]) 
	
	if @iteration.status == "Open"
			@all_iterations = Iteration.find(:all, :select => "status" ,:conditions => {:status => "Open", :project_id => @project.id}).map(&:status).count
			if 	@all_iterations < 1
				@iteration.save
				redirect_to project_iteration_path(@project.id, @iteration.id )
		   else
				flash[:error] ="one iteration is already opened. please select planned"
				redirect_to new_project_iteration_path(@project.id)
			end
	else
			@iteration.save
			redirect_to project_iteration_path(@project.id, @iteration.id )
	end
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
