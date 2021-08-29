require_dependency "vocab/application_controller"

module Vocab
  class LandingsController < ApplicationController
    def show
      @enabled_automation = current_user.enabled_automations.find_by(name: ::Automation::VOCAB)
      if @enabled_automation.present?
        if current_user.automation_enabled?(::Automation::VOCAB) &&
          current_user.todoist_access_token.present?
          @todoist_projects = ::TodoistApi.new(current_user.todoist_access_token).projects.map do |todoist_project|
            TodoistProject.new id: todoist_project["id"], name: todoist_project["name"]
          end
        end
        @linked_project = if @enabled_automation.linked_projects.present?
                            @enabled_automation.linked_projects.last
                          else
                            @enabled_automation.linked_projects.build
                          end
      end
    end
  end
end

