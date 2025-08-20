class SerializableBook < JSONAPI::Serializable::Resource
  type "books"

  attributes :title, :genre, :isbn, :total_copies

  attribute :cover_url do
    @object.cover.url if @object.cover.attached?
  end

  attribute :author_name do
    @object.author.name
  end

  belongs_to :author
end
