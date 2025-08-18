class BorrowingPolicy < ApplicationPolicy
  def index?
    user.librarian? || record.user == user
  end

  def show?
    user.librarian? || record.user == user
  end

  def create?
    user.member?
  end

  def return_book
    user.librarian?
  end
end
