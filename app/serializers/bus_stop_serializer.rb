class BusStopSerializer < ActiveModel::Serializer
  attributes :id, :name, :stop_type
end