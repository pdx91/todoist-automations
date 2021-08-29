class Project < ApplicationRecord
  belongs_to :enabled_automation, class_name: "Automation::Enabled", foreign_key: :enabled_automation_id

  delegate :user, to: :enabled_automation

  before_save do
    if name.blank? && remote_id.present?
      self.name = TodoistApi.new(user.todoist_access_token).project(remote_id)["name"]
    end
  end
end
