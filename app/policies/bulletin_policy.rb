# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def show?
    record.published? || current_user? || user&.admin?
  end

  def create?
    user
  end

  def update?
    current_user?
  end

  def moderation?
    user&.admin?
  end

  def to_moderation?
    current_user?
  end

  def archive?
    current_user? || user&.admin?
  end

  private

  def current_user?
    record.user_id == user&.id
  end
end
