class Book < ApplicationRecord
  belongs_to :author
  has_many :borrowings

  validates :title, presence: true
  validates :genre, presence: true
  validates :isbn, presence: true, uniqueness: true


  def is_available?
    borrowings.where(returned_at: nil).empty?
  end
end
