class Automation
  include ActiveModel::Model

  attr_accessor :name, :path
  validates_presence_of :name, :path

  def self.all
    [
      new(name: "Vocab Builder", path: Rails.application.routes.url_helpers.vocab_path)
    ]
  end
end