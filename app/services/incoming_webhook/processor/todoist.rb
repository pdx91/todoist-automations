class IncomingWebhook::Processor::Todoist < IncomingWebhook::Processor
  attr_reader :webhook, :user

  def process
    if processable?
      webhook.user = user
      processing_engines[engine_key].new(user, task_id).process
    end
  end

  private

  def processable?
    event_supported? && automation_enabled_for_project?
  end

  def event_supported?
    event_name == "item:added"
  end

  def automation_enabled_for_project?
    automation_projects.present?
  end

  def automation_projects
    user.projects.where(remote_id: project_id)
  end

  def event_name
    webhook.raw["event_name"]
  end

  def user
    @user ||= User.find_by uid: webhook.raw["user_id"]
  end

  def project_id
    webhook.raw.dig "event_data", "project_id"
  end

  def engine_key
    automation_projects.last.enabled_automation.name
  end

  def task_id
    webhook.raw.dig "event_data", "id"
  end
end