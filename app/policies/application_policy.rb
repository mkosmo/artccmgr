# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    vatsim_admin? || false
  end

  def show?
    vatsim_admin? || false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  # VATSIM Administrators are permitted to have read-only access to
  # every part of the website to satisfy CoR §3.05(B)(8). This covers
  # forums and discussion groups.
  #
  def vatsim_admin?
    return unless user.present?
    true if user.rating == Vatsim::Rating.find_by(short_name: "ADM")
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def vatsim_admin?
      true if user.rating == Vatsim::Rating.find_by(short_name: "ADM")
    end

    def resolve
      if vatsim_admin?
        scope.all
      else
        scope
      end
    end
  end
end
