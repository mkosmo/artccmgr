# frozen_string_literal: true

class Training::SessionPolicy < ApplicationPolicy
  def show?
    super || record.user == user
  end

  def update?
    return false if record.user == user
    true
  end

  def permitted_attributes
    [:training_session, notes_attributes: [:comment, :staff_comment]]
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
