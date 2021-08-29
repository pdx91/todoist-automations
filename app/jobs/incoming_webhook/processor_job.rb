class IncomingWebhook::ProcessorJob < ApplicationJob
  queue_as :default

  def perform(webhook)
    ::IncomingWebhook::Processor.new(webhook).process
  end
end
