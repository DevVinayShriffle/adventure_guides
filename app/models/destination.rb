class Destination < ApplicationRecord
  has_many_attached :images

  validates :name, presence: true
  validates :location, presence: true

  has_many :schedules, dependent: :destroy
  
  before_validation :normalize_name, :normalize_description, :normalize_location

  broadcasts_to ->(destination) { "destinations" }

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
end
