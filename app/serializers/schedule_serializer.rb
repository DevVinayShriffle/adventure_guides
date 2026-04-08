class ScheduleSerializer < ActiveModel::Serializer
  attributes :id, :destination, :arrival, :departure, :available_seats 
  
  belongs_to :bus

  def destination
    object&.destination&.name
  end
end
