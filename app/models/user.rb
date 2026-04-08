class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable,
  :jwt_authenticatable,
  jwt_revocation_strategy: self

  has_one_attached :avatar

  include Rails.application.routes.url_helpers

  def avatar_url
    if avatar.attached?
      rails_blob_url(avatar, only_path: false)
    else
      "default_avatar.png"
    end
  end

  enum :role, {tourist: 0, guide: 1, admin: 2}

  validates :name, presence: true, length: { maximum: 20 }

  validates :email,
  presence: true,
  uniqueness: true,
  format: {
    with: URI::MailTo::EMAIL_REGEXP,
    message: "must be a valid email address"
  }
  has_many :buses
  has_many :bookings, dependent: :destroy

  before_validation :normalize_name, :normalize_email

  after_create :send_welcome_email

  private

  def normalize_name
    self.name = name.strip if name.present?
  end

  def normalize_email
    self.email = email.strip.downcase if email.present?
  end

  def send_welcome_email
    SendEmailsJob.set(wait: 2.minute).perform_later(self)
    # SendEmailsJob.perform_now(self)
  end
end
