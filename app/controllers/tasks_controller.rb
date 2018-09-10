class TasksController < ApplicationController
  def index
    @task = Task.all
  end
  
  def show
    set_task
  end
  
  def new
    @task = Task.new(content: 'タスクを書いてください', status: 'ステータスを書いてください')
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
    @task.destroy
    
    flash[:success] = 'メッセージは正常に削除されました'
    redirect_to tasks_url
  end  
    
    


private

def set_task
  @task = Task.find(params[:id])
end

def task_params
  params.require(:task).permit(:content, :status)
end  

end