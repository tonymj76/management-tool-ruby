class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :user_projects, :user_project_tasks]
  before_action :logged_in_user, only: [:show]
  before_action :is_admin?, only: [:show, :user_projects, :user_project_tasks, :task_show, :task_edit, :task_update, :task_destroy, :project_new, :project_create, :project_show, :project_edit, :project_update, :project_destroy]
  before_action :set_project, only: [:project_show, :project_edit, :project_update, :project_destroy]
  before_action :set_task_project, only: [:task_show, :task_edit, :task_destroy, :task_update, :task_create]
  before_action :set_task, only: [:task_show, :task_edit, :task_update, :task_destroy]
  # GET /users
  # GET /users.json
  def index
    redirect_to root_url, warning: "You are not authorized" unless current_user && is_admin?
    @projects = current_user.projects
    @users = User.all.order(:id)
  end

  def user_projects
    @projects = @user.projects
    render 'users/project_index'
  end

  def user_project_tasks
    @project = @user.projects.find(params[:project_id])
    render 'users/project_show'
  end

  def project_update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to admin_project_url(@project), success: 'Project was successfully updated.' }
        format.json { render 'users/projects/show', status: :ok, location: @project }
      else
        format.html { render 'users/projects/edit' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def project_destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to users_url, success: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def project_edit
    render 'users/projects/edit'
  end

  def project_all
    @owned_projects = Project.where(user_id: current_user.id)
    @projects = current_user.projects
    render 'users/admin_projects'
  end

  def project_new
    @project = current_user.projects.build
    render 'users/projects/new'
  end

  def project_show
    @colaborator = Colaborator.new
    @user_id = current_user.id
    if params[:assoc]
      @assoc = true
      @project = Project.find(params[:id])
    end
    @thread = @project.mthreads.new
    @threads = @project.mthreads.order("created_at desc")
    @collaborators = Colaborator.where(:project_id => @project.id)
    respond_to do |format|
      format.html {render 'users/projects/show'}
    end
  end

  def project_create
    @project = current_user.projects.build(project_params)
    respond_to do |format|
      if @project.save
        format.html { redirect_to admin_project_url(@project) , success: 'Project was successfully created.' }
        format.json { render 'users/projects/show', status: :created, location: @project }
      else
        format.html { render 'users/projects/new', danger: 'Error creating project' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def task_create
    @task = @task_project.tasks.build(task_params)

    if @task.save
      redirect_to(admin_project_url(@task.project))
    else
      render action: 'task_new'
    end
  end

  def task_update
    if @task.update_attributes(task_params)
      redirect_to(admin_project_url(@task.project))
    else
      render action: 'task_edit'
    end
  end

  def task_edit
    render 'users/tasks/edit'
  end
  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def task_destroy
    @task.destroy

    redirect_to admin_project_url(@task.project)
  end
  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      if current_user && current_user.is_admin
        flash[:success] = "User created Successfully"
        redirect_to users_index_path
      else
        log_in @user
        flash[:success] = "Welcome to Awesome Project Manager"
        redirect_to root_url
      end
    else
     flash.now[:danger] = "Error Creating User Account"
     render :new
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      p user_edit_params
      if @user.update(user_edit_params)
        current_user && !current_user.is_admin ? format.html { redirect_to @user, info: 'User was successfully updated.' } : format.html { redirect_to users_index_path, info: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        Rails.logger.info(@user.errors.inspect) 
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    p @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, info: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_project
      @task_project = Project.find(params[:project_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_project
        @project = Project.find_by(user_id: current_user.id, id: params[:id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def set_task
      @task = @task_project.tasks.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :is_admin)
    end

    def user_edit_params
      params.require(:user).permit(:first_name, :last_name, :email, :is_admin)
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:name, :description, :user_id, uploads: [] )
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:name, :description, :status, :project_id)
    end
end
