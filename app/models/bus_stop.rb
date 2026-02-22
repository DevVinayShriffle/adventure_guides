class BusStop < ApplicationRecord
  validates :name, presence: true
  validates :stop_type, presence: true
  validates :stop_type, inclusion: { in: ["pickup", "drop"], message: "must be pickup or drop" }
    
  before_validation :normalize_name
    
  belongs_to :bus
  private

  def normalize_name
    self.name = name.strip if name.present?
  end
end