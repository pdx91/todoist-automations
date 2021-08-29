class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,
    :omniauthable, omniauth_providers: %i[todoist]

  has_many :enabled_automations, class_name: "Automation::Enabled"
  has_many :projects, through: :enabled_automations, dependent: :destroy, source: :linked_projects
  has_many :incoming_webhooks, dependent: :destroy

  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.todoist_access_token = auth.credentials.token
    end

    user.tap { user.save unless user.persisted? }
  end

  def automation_enabled?(name)
    enabled_automations.map(&:name).uniq.include? name
  end
end
