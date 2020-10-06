class ProjectsController < ApplicationController
    # before_action :authenticate
    before_action :set_project, only: [:show, :edit, :update, :destroy]

    def index
      if !logged_in? 
         redirect_to user_session_path
      else
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
        @task = @project.tasks.build
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
        @project = current_user.projects.find(params[:id])
    end
    # Only allow a list of trusted parameters through.
    def project_params
        params.require(:project).permit(:name, :description)
    end
end
