class EnabledAutomationsController < ApplicationController
  def create
    @enabled_automation = current_user.enabled_automations.create! create_params
    redirect_back fallback_location: root_path
  end

  private

  def create_params
    params.require(:automation_enabled).permit :name
  end
end
