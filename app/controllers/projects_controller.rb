class ProjectsController < ApplicationController
    # before_action :authenticate
    before_action :set_project, only: [:show, :edit, :update, :destroy]

    def index
      if !logged_in?
         redirect_to user_session_path
      else
        @owned_projects = Project.where(user_id: current_user.id)
        @projects = current_user.projects
      end
    end
  
    def create
        @project = current_user.projects.build(project_params)
        respond_to do |format|
          if @project.save
            format.html { redirect_to @project, success: 'Project was successfully created.' }
            format.json { render :show, status: :created, location: @project }
          else
            format.html { render :new, danger: 'Error creating project' }
            format.json { render json: @project.errors, status: :unprocessable_entity }
          end
        end
    end

    def new
        @project = current_user.projects.build
    end

    def edit
    end

    def show
      @colaborator = Colaborator.new
      @user_id = current_user.id if current_user.present?
      @project = Project.find(params[:id])
      @thread = @project.mthreads.new
      @task = @project.tasks.build
        if params[:assoc]
           @assoc = true
           @threads = @project.mthreads.order("created_at desc")
           @collaborators = Colaborator.where(:project_id => @project.id)
        else
          @assoc = false
          @project.present? ? @threads = @project.mthreads.order("created_at desc") : @threads = []
          @project.present? ? @collaborators = Colaborator.where(:project_id => @project.id) : @collaborators = []
        end
    end

    def update 
        respond_to do |format|
            if @project.update(project_params)
              format.html { redirect_to @project, success: 'Project was successfully updated.' }
              format.json { render :show, status: :ok, location: @project }
            else
              format.html { render :edit }
              format.json { render json: @project.errors, status: :unprocessable_entity }
            end
          end
    end

    def destroy 
        @project.destroy
        respond_to do |format|
          format.html { redirect_to projects_url, success: 'Project was successfully destroyed.' }
          format.json { head :no_content }
        end 
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
        @project = Project.find_by(user_id: current_user.id, id: params[:id]) if current_user.present? && params[:id].present?
    end
    # Only allow a list of trusted parameters through.
    def project_params
        params.require(:project).permit(:name, :description, :user_id, uploads: [])
    end
end
