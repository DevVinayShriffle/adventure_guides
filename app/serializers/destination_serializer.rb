class DestinationSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :description, :location, :image_urls

  def image_urls
    if object.images.attached?
      object.images.map do |image|
        rails_blob_url(image, only_path: false)
      end
    end
  end
end
