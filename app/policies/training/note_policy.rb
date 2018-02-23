# frozen_string_literal: true

class Training::NotePolicy < ApplicationPolicy
  def create?
    super || true
  end

  def permitted_attributes
    [:comment, :staff_comment]
  end
end
