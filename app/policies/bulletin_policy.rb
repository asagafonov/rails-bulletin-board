# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    record.published? || record.user_id == user&.id || user&.admin?
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

  def moderation?
    user&.admin?
  end

  def to_moderation?
    record.user_id == user&.id
  end

  def publish?
    user&.admin?
  end

  def reject?
    user&.admin?
  end

  def archive?
    record.user_id == user&.id || user&.admin?
  end
end
