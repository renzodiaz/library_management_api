class SerializableBorrowing < JSONAPI::Serializable::Resource
  type "borrowings"

  attributes :user_id, :book_id, :returned_at, :borrowed_at, :due_date

  belongs_to :user
  belongs_to :book
end
