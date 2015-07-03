class VenueSerializer < ActiveModel::Serializer
  def attributes
    data = super
    data[:text] = object.name
    data
  end
end
