class User < ApplicationRecord
  has_one_attached :avatar

  enum :role, {tourist: 0, guide: 1, admin: 2}

  validates :name, presence: true, length: { maximum: 20 }

  validates :email,
  presence: true,
  uniqueness: true,
  format: {
    with: URI::MailTo::EMAIL_REGEXP,
    message: "must be a valid email address"
  }

  has_many :bookings, dependent: :destroy

  before_validation :normalize_name, :normalize_email

  private

  def normalize_name
    self.name = name.strip if name.present?
  end

  def normalize_email
    self.email = email.strip.downcase if email.present?
  end
end
