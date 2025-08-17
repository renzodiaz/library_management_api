class Book < ApplicationRecord
  belongs_to :author

  validates :title, presence: true
  validates :genre, presence: true
  validates :isbn, presence: true, uniqueness: true
end
