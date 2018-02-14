# frozen_string_literal: true

class Training::Progress < ApplicationRecord
  # Audit configuration
  audited

  # ActiveRecord associations
  belongs_to :user
  belongs_to :block, class_name: "Training::Block"

  # ActiveRecord callbacks
  after_initialize :set_started_at

  # ActiveRecord validations
  validates :block, uniqueness: { scope: :user }
  validates :started_at,
            presence: true,
            allow_blank: false

  validate :valid_completion_time

  # ActiveRecord scopes
  scope :completed,  -> { where.not(completed_at: "NULL") }
  scope :incomplete, -> { where(completed_at: "NULL") }

  def completed?
    completed_at.present?
  end

  private

    def set_started_at
      return unless started_at.nil?
      self.started_at = Time.now.utc
    end

    def valid_completion_time
      return if completed_at.nil?
      if completed_at < started_at
        errors.add :completed_at, "cannot be before started_at"
      end
    end
end
