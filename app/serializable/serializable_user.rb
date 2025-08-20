class SerializableUser < JSONAPI::Serializable::Resource
  type "users"

  attributes :first_name, :last_name, :email, :role, :last_logged_in_at,
   :confirmed_at, :confirmation_sent_at, :reset_password_sent_at, :created_at, :updated_at
end
