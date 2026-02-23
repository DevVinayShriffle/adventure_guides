class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :phone, :role, :email, :jti
end
