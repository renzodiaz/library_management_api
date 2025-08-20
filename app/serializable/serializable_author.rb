class SerializableAuthor < JSONAPI::Serializable::Resource
  type "authors"

  attributes :first_name, :last_name
end
