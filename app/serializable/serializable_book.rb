class SerializableBook < JSONAPI::Serializable::Resource
  type "books"

  attributes :title, :genre, :isbn

  belongs_to :author
end
