# frozen_string_literal: true

class Training::SessionsController < ApplicationController
  before_action :authenticate_user!

  def show
    @session = Training::Session.find(params[:id])
    authorize @session, :show?
    @session.notes.build
  end

  def update
    @session = Training::Session.find(params[:id])
    authorize @session, :update?

    # Integrity enforcement: ensure all notes belong to the
    # session student and current_user as instructor
    session_attributes = session_params.to_h

    if session_attributes["notes_attributes"].present?
      session_attributes["notes_attributes"].each_value do |note|
        note["user"] = @session.user
        note["instructor"] = current_user
      end
    end

    if @session.update_attributes(session_attributes)
      redirect_to @session, notice: "Training session updated"
    else
      flash[:error] = "Unable to update training session"
      render :show
    end
  end

  private

    def session_params
      params.require(:training_session).permit(policy(@session).permitted_attributes)
    end
end
