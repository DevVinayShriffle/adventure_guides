class Bus < ApplicationRecord
  has_many_attached :images

  enum :bus_type, {sitter: 0, sleeper: 1, ac: 2}

  validates :name, presence: true
  validates :capacity, numericality:{ greater_than: 0 }, presence: true
  validates :price, numericality:{ greater_than_or_equal_to: 0 }, presence: true

  belongs_to :user  #here user is guide role
  has_many :schedules, dependent: :destroy
  has_many :bus_stops, dependent: :destroy

  before_validation :normalize_name
  broadcasts_to ->(bus) { "buses" }

  private

  def normalize_name
    self.name = name.strip if name.present?
  end
end
