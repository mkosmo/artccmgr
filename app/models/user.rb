# frozen_string_literal: true

class User < ApplicationRecord
  # Audit configuration
  audited

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :trackable

  #
  # ActiveRecord associations
  #

  # VATSIM Properties
  belongs_to :facility, class_name: "Vatsim::Facility", optional: true
  belongs_to :rating,   class_name: "Vatsim::Rating"

  # Instructor associations
  has_many :instructor_notes,
           class_name:  "Training::Note",
           foreign_key: :instructor_id,
           dependent:   :nullify

  has_many :instructor_sessions,
           class_name:  "Training::Session",
           foreign_key: :instructor_id,
           dependent:   :nullify

  has_many :instructor_ots_recommendations,
           class_name:  "Training::Ots::Recommendation",
           foreign_key: :instructor_id,
           dependent:   :nullify

  has_many :instructor_ots_results,
           class_name:  "Training::Ots::Result",
           foreign_key: :instructor_id,
           dependent:   :nullify

  # Student associations
  has_many :training_notes,
           class_name: "Training::Note",
           dependent: :destroy

  has_many :training_sessions,
           class_name: "Training::Session",
           dependent: :destroy

  has_many :training_ots_recommendations,
           class_name: "Training::Ots::Recommendation",
           foreign_key: "user_id",
           dependent: :destroy

  has_many :training_ots_results,
           class_name: "Training::Ots::Result",
           through: :training_ots_recommendations,
           source:  :result

  has_many :training_progress,
           class_name: "Training::Progress",
           dependent: :destroy

  # ActiveRecord validations
  validates :cid,
            presence:     true,
            allow_blank:  false,
            uniqueness:   true,
            numericality: { greater_than: 0 }

  validates :first_name,  presence: true, allow_blank: false
  validates :last_name,   presence: true, allow_blank: false
  validates :email,       presence: true, allow_blank: false
  validates :reg_date,    presence: true, allow_blank: false

  validates :initials, length: { maximum: 2 }

  # ActiveRecord delegations
  delegate :division, to: :facility
  delegate :region,   to: :division

  # Returns the full name of the user with rating
  #   "John Smith (OBS)"
  #
  def to_s
    "#{first_name} #{last_name} (#{rating.short_name})"
  end
end
