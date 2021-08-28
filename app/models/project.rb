class Project < ApplicationRecord
  belongs_to :enabled_automation, class_name: "Automation::Enabled", foreign_key: :enabled_automation_id
end
