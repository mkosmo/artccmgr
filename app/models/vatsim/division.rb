# frozen_string_literal: true

class Vatsim::Division < ApplicationRecord
  # Audit configuration
  audited associated_with: :region

  # ActiveRecord associations
  belongs_to :region, class_name: "Vatsim::Region"

  has_many :facilities, foreign_key: "division_id", dependent: :destroy

  # ActiveRecord validations
  validates :name,
            presence:     true,
            allow_blank:  false,
            uniqueness:   { case_sensitive: false }

  validates :short_name,
            presence:     true,
            allow_blank:  false,
            uniqueness:   { case_sensitive: false }
end
