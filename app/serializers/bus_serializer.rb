class BusSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :bus_type, :capacity, :price, :images_urls

  def images_urls
    return [] unless object.images.attached?

    object.images.map do |image|
      rails_blob_url(image)
    end
  end
end
