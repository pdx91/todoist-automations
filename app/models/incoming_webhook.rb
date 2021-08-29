class IncomingWebhook < ApplicationRecord
  TODOIST = "todoist"
  ALLOWED_SOURCES = %W[#{TODOIST}]

  belongs_to :user, optional: true

  serialize :raw, JSON

  validates_presence_of :raw
  validates_presence_of :user, if: :processed?
  validates_inclusion_of :source, in: ALLOWED_SOURCES

  after_create_commit :process

  ALLOWED_SOURCES.each do |source|
    define_method("#{source}?") { self.source.eql? source }
  end

  private

  def process
    IncomingWebhook::Processor.new(self).process
  end
end
