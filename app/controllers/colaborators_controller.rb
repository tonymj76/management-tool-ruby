class ColaboratorsController < ApplicationController
    def create
        project_id = params[:colaborator][:project_id]
        @users = params[:colaborator][:user_id].select {|e| e != ""}
        colaborators = []
        @users.each do |user|
            colab = {user_id: user.to_i, project_id: project_id}
            colaborators << colab
        end

        if colaborators.size > 0
            @colaborators = Colaborator.create(colaborators)
            respond_to do |format|
                if @colaborators
                format.html { redirect_to request.referer, success: 'Users was successfully assigned to project.' }
                else
                format.html { redirect_to request.referer, danger: 'Error adding colaborators project' }
                format.json { render json: @project.errors, status: :unprocessable_entity }
                end
            end
        else
            respond_to do |format|
                format.html { redirect_to request.referer, danger: 'Select atleast one(1) User for colaboration' }
                format.json { render json: @project.errors, status: :unprocessable_entity }
                end
        end
    end

    def destroy 
        @colaborator = Colaborator.find(params[:id])
        @colaborator.destroy
        respond_to do |format|
          format.html { redirect_to request.referer, success: 'Collaborator was successfully removed from project.' }
          format.json { head :no_content }
        end 
    end
end
