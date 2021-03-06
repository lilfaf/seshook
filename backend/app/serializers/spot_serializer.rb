class SpotSerializer < ActiveModel::Serializer
  attributes :id, :name, :latlon, :created_at, :updated_at

  has_one :address
  has_one :user

  def latlon
    [object.latitude, object.longitude]
  end
end
