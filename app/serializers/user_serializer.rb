class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :phone, :role, :email, :jti, :avatar_url

  def avatar_url
    return unless object.avatar.attached?

    Cloudinary::Utils.cloudinary_url(object.avatar.key)
  end
end
