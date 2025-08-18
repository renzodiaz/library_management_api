class BookPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  # Only librarian can manage books
  def create?
    user.librarian?
  end

  def update?
    user.librarian?
  end

  def destroy?
    user.librarian?
  end
end
