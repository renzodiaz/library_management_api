class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :book

  before_validation :set_borrowed_dates, on: :create

  validates :user, presence: true
  validates :book, presence: true
  validates :book_id, uniqueness: { scope: [ :user_id, :returned_at ],
                                    message: "is already borrowed by this user" }

  scope :active, -> { where(returned_at: nil) }
  scope :overdue, -> { active.where("due_date < ?", Time.current) }

  private

  def set_borrowed_dates
    self.borrowed_at ||= Time.current
    self.due_date ||= 2.weeks.from_now
  end
end
