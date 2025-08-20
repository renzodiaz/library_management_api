class Book < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [ :title, :genre, :author_name ]

  has_one_attached :cover do |attachable|
    attachable.variant :thumb, resize_to_limit: [ 150, 150 ]
  end

  belongs_to :author
  has_many :borrowings

  validates :title, presence: true
  validates :genre, presence: true
  validates :isbn, presence: true, uniqueness: true


  def author_name
    author&.name
  end

  def is_available?
    borrowings.where(returned_at: nil).empty?
  end
end
