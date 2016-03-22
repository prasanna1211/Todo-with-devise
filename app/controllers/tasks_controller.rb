class TasksController < ApplicationController
	before_filter :check_login
  before_filter :get_task, only: [:edit, :update, :destroy] 

  def index
    @tasks = current_user.tasks.all
    if params[:filter] == "Priority"
      @tasks = @tasks.order(priority: :desc)
    elsif params[:filter] =="Latest"
      @tasks = @tasks.order(created_at: :desc)
    end
  end

	def new
		@task = Task.new
    puts @task
	end

	def create
		@task = current_user.tasks.create(task_params)
		redirect_to tasks_path
	end

	def edit
	end

	def update
    @task.update(task_params)
    redirect_to tasks_path
	end

	def destroy
    @task.destroy
    redirect_to tasks_path
	end

	private 

  def check_login
    if !user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def get_task
    @task = current_user.tasks.find(params[:id])
  end

	def task_params
		params.require(:task).permit(:title, :description, :priority)
	end

end
