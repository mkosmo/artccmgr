# frozen_string_literal: true

class Training::ProfilePolicy < ApplicationPolicy
  def show?
    super || user.present?
  end
end
