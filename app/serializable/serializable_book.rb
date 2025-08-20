class SerializableBook < JSONAPI::Serializable::Resource
  type "books"

  attributes :title, :genre, :isbn, :total_copies

  belongs_to :author
end
