module ColaboratorsHelper
    def user_options (current_user_id, project_id)
        User.all.select { |u| u.id != current_user_id and exclude?(project_id, u.id, current_user_id)  }.map { |u| ["#{u.first_name} #{u.last_name}", u.id] }
    end
    def exclude? (project_id, user_id, current_user_id)
        colaborators = Colaborator.select(:user_id).where(:project_id=> project_id)
        colaborators.map{|x| x.user_id }.exclude?(user_id)
    end
end
