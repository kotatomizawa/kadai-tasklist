class TasksController < ApplicationController
  def index
    @task = Task.all
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def new
    @task = Task.new(content: 'ここに書いてください')
  end
  
  def create
        @task = Task.new(task_params)
    
    if @task.save
      flash[:success] = 'メッセージが正常に投稿されました'
      redirect_to @task
    else
      flash.now[:danger] = 'メッセージが投稿されませんでした'
      render :new
    end  
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])
    
    if @task.update(task_params)
      flash[:success] = 'メッセージが正常に編集されました'
      redirect_to @task
    else
      flash.now[:danger] = 'メッセージを編集できませんでした'
      render :edit
    end  
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = 'メッセージは正常に削除されました'
    redirect_to tasks_url
  end  
    
    
end

private

def task_params
  params.require(:task).permit(:content)
end  