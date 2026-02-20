class Destination < ApplicationRecord
  has_many_attached :image

  validates :name, null:false
  validates :location, null:false

  has_many :schedules
  
  before_validation :normalize_name, :normalize_descryption, :normalize_location

  private
  def normalize_name
    self.name = name.strip if name.present?
  end

  def normalize_descryption
    self.descryption = descryption.strip if descryption.present?
  end

  def normalize_location
    self.location = location.strip if location.present?
  end
end
