class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
    if logged_in?
      @task = current_user.tasks.build  
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
    end
  end
  
  def show
    @task = current_user.tasks.find_by(id: params[:id])
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'task added'
      redirect_to root_url
    else
      @tasks = current_user
      flash.now[:danger] = 'task not added'
      render 'new'
    end
  end
  
  def edit
    @task = current_user.tasks.find_by(id: params[:id])
  end
  
  def update
    @task = current_user.tasks.find_by(params[:id])
    if @task.update(task_params)
      flash[:success] = 'メッセージが正常に編集されました'
      redirect_to @task
    else
      flash.now[:danger] = 'メッセージを編集できませんでした'
      render :edit
    end  
  end
  
  def destroy
    @task.destroy
    flash[:success] = 'task deleted'
    redirect_back(fallback_location: root_path)
  end  
    

  private
  
  
  def task_params
    params.require(:task).permit(:content, :status)
  end  
  
  def correct_user
      @task = current_user.tasks.find_by(id: params[:id])
      unless @task
        redirect_to root_url
      end
  end

end  