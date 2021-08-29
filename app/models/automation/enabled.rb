class Automation::Enabled < ApplicationRecord
  self.table_name = "enabled_automations"

  has_many :linked_projects, class_name: "Project", foreign_key: :enabled_automation_id
  belongs_to :user

  validates :name, presence: true, inclusion: {in: Automation::AVAILABLE_AUTOMATIONS}

  Automation::AVAILABLE_AUTOMATIONS.each do |automation|
    define_method("#{automation}?") { name.eql? name }
  end
end
