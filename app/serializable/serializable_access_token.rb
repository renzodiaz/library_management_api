class SerializableAccessToken < JSONAPI::Serializable::Resource
  type "access_tokens"

  attribute :token do
    @object.generate_token
  end

  attributes :user_id

  belongs_to :user
end
