class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :phone, :role, :email, :jti, :avatar_url

  def avatar_url
    # return unless object.avatar.attached?
    if object.avatar.attached?
      rails_blob_url(object.avatar)
    else
      "http://localhost:3000/default_avatar.png"
    end
  end
end
