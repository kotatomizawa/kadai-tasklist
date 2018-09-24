class TasksController < ApplicationController
  before_action :require_user_logged_in
  def index
    if logged_in?
      @task = current_user.tasks.build  
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
    end
  end
  
  def show
    set_task
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
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'task not added'
      render 'new'
    end
  end
  
  def edit
   set_task 
  end
  
  def update
    set_task

    if @task.update(task_params)
      flash[:success] = 'メッセージが正常に編集されました'
      redirect_to @task
    else
      flash.now[:danger] = 'メッセージを編集できませんでした'
      render :edit
    end  
  end
  
  def destroy
    set_task
    @micropost.destroy
    flash[:success] = 'tasl deleted'
    redirect_back(fallback_location: root_path)
  end  
    
    


private

def set_task
  @task = Task.find(params[:id])
end

def task_params
  params.require(:task).permit(:content, :status)
end  

end