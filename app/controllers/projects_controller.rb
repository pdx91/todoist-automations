class ProjectsController < ApplicationController
  def create
    enabled_automation = current_user.enabled_automations.find(params[:enabled_automation_id])
    @project = enabled_automation.linked_projects.create \
                remote_id: params.require(:project).permit(:todoist_id)[:todoist_id]

    redirect_back fallback_location: root_path
  end
end
