class Destination < ApplicationRecord
  has_paper_trail on: [:create, :update, :destroy], ignore: [:updated_at]
  has_many_attached :images

  validates :name, presence: true
  validates :location, presence: true

  has_many :schedules, dependent: :destroy
  
  before_validation :normalize_name, :normalize_description, :normalize_location

  # after_commit :create_version, on: :update

  private
  def normalize_name
    self.name = name.strip if name.present?
  end

  def normalize_description
    self.description = description.strip if description.present?
  end

  def normalize_location
    self.location = location.strip if location.present?
  end

  def create_version
    self.paper_trail.record_update(
      force: true,
      in_after_callback: true,
      is_touch: false
    )
  end
end
