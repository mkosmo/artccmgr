# frozen_string_literal: true

class Training::SessionsController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize Training::Session, :index?
    @q = policy_scope(Training::Session).ransack(params[:q])
    @q.sorts  = "started_at desc" if @q.sorts.empty?
    @result   = @q.result
    @sessions = @result.page(params[:page])
  end

  def create
    authorize Training::Session, :create?
    @session = Training::Session.new(instructor: current_user)

    unless policy(@session).modify_instructor?
      @session.instructor = current_user
    end

    # Integrity enforcement: ensure all notes belong to the
    # session student and current_user as instructor
    session_attributes = session_params.to_h

    if session_attributes["notes_attributes"].present?
      session_attributes["notes_attributes"].each_value do |note|
        note["user_id"] = session_attributes["user_id"]
        note["instructor"] = current_user
      end
    end

    @session.attributes = session_attributes

    if @session.save
      redirect_to @session, notice: "Training session created"
    else
      flash[:error] = "Unable to create training session"
      render :new
    end
  end

  def destroy
    @session = Training::Session.find(params[:id])
    authorize @session, :destroy?

    if @session.destroy
      redirect_to training_sessions_path, notice: "Training session deleted"
    else
      flash[:error] = "Unable to delete the training session"
      render :edit
    end
  end

  def edit
    @session = Training::Session.find(params[:id])
    authorize @session, :edit?
  end

  def new
    authorize Training::Session, :new?
    @session = Training::Session.new(
      instructor: current_user,
      started_at: Time.now.utc,
      ended_at: Time.now.utc
    )
    @session.notes.build
  end

  def show
    @session = Training::Session.find(params[:id])
    authorize @session, :show?
    @session.notes.build
  end

  def update
    @session = Training::Session.find(params[:id])
    authorize @session, :update?

    unless policy(@session).modify_instructor?
      @session.instructor = current_user
    end

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
