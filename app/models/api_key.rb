class ApiKey < ApplicationRecord
  before_validation :generate_key, on: :create

  validates :app_name, presence: true
  validates :key, presence: true
  validates :active, presence: true

  # get all active keys
  scope :activated, -> { where(active: true) }


  def disable
    update_column :active, false
  end

  private

  def generate_key
    self.key = SecureRandom.hex
  end
end
