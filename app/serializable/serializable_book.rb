class SerializableBook < JSONAPI::Serializable::Resource
  include Rails.application.routes.url_helpers
  type "books"

  attributes :title, :genre, :isbn, :total_copies

  attribute :cover_url do
    url_for(@object.cover) if @object.cover.attached?
  end

  belongs_to :author
end
