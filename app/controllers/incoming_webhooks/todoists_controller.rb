class IncomingWebhooks::TodoistsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :log_webhook

  def create
    IncomingWebhook.create! raw: params[:todoist], source: IncomingWebhook::TODOIST

    head :ok
  end

  private

  def log_webhook
    Rails.logger.info "Webhook Received: #{params}"
  end
end
