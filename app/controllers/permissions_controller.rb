class PermissionsController < ApplicationController

    def index
        @collaborators = Colaborator.where(:project_id => params[:project_id])
    end
    
    def update
        rec = ColHasPermission.where({colaborator_id: params[:col_id]})
        rec.each { |r| r.destroy }
        perms = params[:permission_ids]
        perms.each_with_index do |perm, i|
            next if i == 0
            ColHasPermission.create({ colaborator_id: params[:col_id], permission_id: perm })
        end
        redirect_to(request.referrer, success: "Permissions set")
    end

    def edit
        @permissions = Permission.all
        @col = Colaborator.find(params[:id])
        @perms = @col.col_has_permissions.map { |p| p.permission_id }
        respond_to do |format|
            format.js
        end
    end
end