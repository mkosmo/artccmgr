# frozen_string_literal: true

class Training::SessionPolicy < ApplicationPolicy
  def index?
    super || true
  end

  def create?
    super || true
  end

  def destroy?
    super || true
  end

  # Whether a user can modify the instructor on the session
  def modify_instructor?
    true
  end

  def new?
    super || true
  end

  def show?
    super || record.user == user
  end

  def update?
    return false if record.user == user
    true
  end

  def permitted_attributes
    attributes = [:user_id, :started_at, :ended_at, :type_id, notes_attributes: [:comment, :staff_comment]]

    if modify_instructor?
      attributes.push :instructor_id
    end

    attributes
  end

  class Scope < Scope
    def resolve
      if vatsim_admin?
        scope.all
      else
        scope.where(user: @user)
      end
    end
  end
end
