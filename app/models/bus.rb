class Bus < ApplicationRecord
  has_many_attached :image

  enum :type, {sitter: 0, sleeper: 1, ac: 2}

  validates :name, null:false
  validates :type, inclusion: {in: types.keys, message: "is not a valid bus type."}
  validates :capacity, numericality:true, null:false
  validates :price, numericality:true, null:false

  has_many :schedules

  before_validation :normalize_name

  private

  def normalize_name
    self.name = name.strip if present?
  end
end
