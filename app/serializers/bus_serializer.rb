class BusSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :bus_type, :capacity, :price, :image_urls

  has_many :bus_stops
  
  def image_urls
    # return [] unless object.images.attached?

    object.images.map do |image|
      rails_blob_url(image)
    end
  end
end
