# frozen_string_literal: true

class Training::ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    authorize [:training, :profile], :show?
    @sessions = policy_scope(Training::Session).where(user: current_user).order(ended_at: :desc).limit(5)
  end
end
