class AccessToken < ApplicationRecord
  belongs_to :user
  belongs_to :api_key

  validates :user, presence: true
  validates :api_key, presence: true

  after_create :update_accessed_at

  def authenticate(unencrypted_token)
    BCrypt::Password.new(token_digest).is_password?(unencrypted_token)
  end

  def expired?
    created_at + 14.days < Time.now
  end

  def generate_token
    token = SecureRandom.hex
    digest = BCrypt::Password.create(token, cost: BCrypt::Engine.cost)
    update_column(:token_digest, digest)
    token
  end

  private

  def update_accessed_at
    user.update_column(:last_logged_in_at, Time.current)
  end
end
