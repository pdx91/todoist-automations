class IncomingWebhook::Processor
  attr_reader :webhook

  def initialize(webhook)
    @webhook = webhook
  end

  def process
    if webhook.todoist?
      IncomingWebhook::Processor::Todoist.new(webhook).process
    end
  end

  protected

  def processing_engines
    {
      vocab: ::Vocab::Processor
    }.with_indifferent_access
  end
end
