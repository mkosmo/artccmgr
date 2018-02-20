# frozen_string_literal: true

class Training::Note < ApplicationRecord
  # Audit configuration
  audited

  # ActiveRecord associations
  belongs_to :user
  belongs_to :instructor, class_name: "User"
  belongs_to :session, optional: true

  # ActiveRecord validations
  validates :user,       presence: true, allow_blank: false
  validates :instructor, presence: true, allow_blank: false

  validate :comment_present
  validate :student_feedback

  private

    # Validates that either a general comment or a staff comment is present
    # as both cannot be empty.
    #
    def comment_present
      unless comment.present? || staff_comment.present?
        errors.add :base, "either a comment or staff comment must be present"
      end
    end

    # Validates that a general comment is present if related to a
    # Training::Session. It is important that student feedback is enforced.
    #
    def student_feedback
      return unless session.present?
      unless comment.present?
        errors.add :comment, "must be present"
      end
    end
end
