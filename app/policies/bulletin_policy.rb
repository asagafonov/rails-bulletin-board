# frozen_string_literal: true

class BulletinPolicy
  def index?
    true
  end

  def show?
    true
  end

  def new?
    create?
  end

  def create?
    user
  end

  def edit?
    update?
  end

  def update?
    record.user_id == user&.id
  end

  def destroy?
    record.user_id == user&.id || user&.admin?
  end
end
