class TodoistApi
  attr_reader :access_token

  def initialize(access_token)
    @access_token = access_token
  end

  def projects(options = {})
    HTTParty.get(
      "https://api.todoist.com/rest/v1/projects",
      headers: {
        Authorization: "Bearer #{access_token}"
      }
    ).parsed_response
  end

  def project(id)
    HTTParty.get(
      "https://api.todoist.com/rest/v1/projects/#{id}",
      headers: {
        Authorization: "Bearer #{access_token}"
      }
    ).parsed_response
  end

  def tasks(options = {})
    project_id = options[:project_id]
    query = project_id.present? ? {project_id: project_id} : {}

    HTTParty.get(
      "https://api.todoist.com/rest/v1/tasks",
      query: query,
      headers: {
        Authorization: "Bearer #{access_token}"
      }
    ).parsed_response
  end

  def task(id)
    HTTParty.get(
      "https://api.todoist.com/rest/v1/tasks/#{id}",
      headers: {
        Authorization: "Bearer #{access_token}"
      }
    ).parsed_response
  end

  def update_task(task_id, attributes = {})
    # Only allow updating description for now.
    description = attributes[:description]
    content = attributes[:content]
    body = {}
    body[:description] = description if description.present?
    body[:content] = content if content.present?

    HTTParty.post(
      "https://api.todoist.com/rest/v1/tasks/#{task_id}",
      body: body.to_json,
      headers: {
        "X-Request-Id": SecureRandom.uuid,
        "Content-Type": "application/json",
        Authorization: "Bearer #{access_token}"
      }
    ).parsed_response
  end

  private

  def allowed_attributes_to_update
    %i[description]
  end
end
