class Bus < ApplicationRecord
  has_many_attached :images

  enum :bus_type, {sitter: 0, sleeper: 1, ac: 2}

  validates :name, presence: true
  validates :bus_type, presence: true #inclusion: {in: bus_types.keys, message: "is not a valid bus type."}
  validates :capacity, numericality:{ greater_than: 0 }, presence: true
  validates :price, numericality:{ greater_than_or_equal_to: 0 }, presence: true

  has_many :schedules, dependent: :destroy
  has_many :bus_stops, dependent: :destroy

  before_validation :normalize_name

  private

  def normalize_name
    self.name = name.strip if name.present?
  end
end
