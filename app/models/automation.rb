class Automation
  include ActiveModel::Model

  VOCAB = "vocab"
  AVAILABLE_AUTOMATIONS = %W[#{VOCAB}]

  attr_accessor :name, :path, :key
  validates_presence_of :name, :path, :key
  validates_inclusion_of :key, in: AVAILABLE_AUTOMATIONS

  def self.all
    [
      new(
        name: "Vocab Builder",
        path: Rails.application.routes.url_helpers.vocab_path,
        key: VOCAB
      )
    ]
  end
end
