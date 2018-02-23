# frozen_string_literal: true

class Training::Session < ApplicationRecord
  # Disable STI
  self.inheritance_column = nil

  # Audit configuration
  audited

  # ActiveRecord associations
  belongs_to :user
  belongs_to :instructor, class_name: "User"
  belongs_to :type,       class_name: "Training::Type"

  has_many :notes, class_name: "Training::Note", dependent: :destroy

  has_one :ots,      class_name: "Training::Ots::Result", dependent: :nullify
  has_one :progress, class_name: "Training::Progress",    dependent: :nullify

  # ActiveRecord validations
  validates :user,       presence: true, allow_blank: false
  validates :instructor, presence: true, allow_blank: false
  validates :type,       presence: true, allow_blank: false
  validates :started_at, presence: true, allow_blank: false
  validates :ended_at,   presence: true, allow_blank: false

  validate :instructor_not_student
  validate :note_exists
  validate :valid_end_time

  accepts_nested_attributes_for :notes

  # Returns true/false if this session represents an OTS
  #
  def ots?
    ots.present?
  end

  private

    # Validates that an instructor cannot perform their own training
    #
    def instructor_not_student
      if user == instructor
        errors.add :instructor, "cannot train yourself"
      end
    end

    # Validates that at least one training note must exist for the session
    #
    def note_exists
      if notes.empty?
        errors.add :notes, "at least one must be present"
      end
    end

    # Validates the session end time is after the session start time
    #
    def valid_end_time
      return if ended_at.nil?
      unless Time.at(ended_at.to_i) >= Time.at(started_at.to_i)
        errors.add :ended_at, "cannot be before start"
      end
    end
end
