class User < ApplicationRecord
  attr_accessor :full_name

  has_secure_password
  has_many :access_tokens
  has_many :borrowings
  has_many :borrowed, through: :borrowings, source: :book

  before_validation :generate_confirmation_token, on: :create
  before_validation :downcase_email
  before_validation :split_full_name

  enum :role, { member: 0, librarian: 1 }

  validates :email, presence: true,
    uniqueness: true,
    length: { maximum: 255 },
    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }

  validates :password, presence: true, length: { minimum: 8 }, if: :new_record?
  validates :first_name, length: { maximum: 100 }
  validates :last_name, length: { maximum: 100 }
  validates :confirmation_token, presence: true,
    uniqueness: { case_sensitive: true }

  def confirm
    update_columns({
      confirmation_token: nil,
      confirmed_at: Time.now
    })
  end

  def init_password_reset(redirect_url)
    assign_attributes({
      reset_password_token: SecureRandom.hex,
      reset_password_sent_at: Time.now,
      reset_password_redirect_url: redirect_url
    })
    save
  end

  def complete_password_reset(password)
    assign_attributes({
      password: password,
      reset_password_token: nil,
      reset_password_sent_at: nil,
      reset_password_redirect_url:  nil
    })
    save
  end

  private

  def generate_confirmation_token
    self.confirmation_token = SecureRandom.hex
  end

  def downcase_email
    email.downcase! if email
  end

  def split_full_name
    return if full_name.blank?
      self.first_name, self.last_name = full_name.split(" ", 2)
  end
end
