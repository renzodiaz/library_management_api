class UserPolicy < ApplicationPolicy
  def index?
    user.librarian?
  end

  def show?
    user.librarian? || record.id == user.id
  end

  def create?
    # Register should be public
    true
  end

  def update?
    user.librarian? || record.id == user.id
  end

  def destroy?
    # avoid librarian remove other librarians
    user.librarian? && record.member?
  end
end
