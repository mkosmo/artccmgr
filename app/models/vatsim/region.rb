# frozen_string_literal: true

class Vatsim::Region < ApplicationRecord
  # Audit configuration
  audited

  # ActiveRecord associations
  has_many :divisions, foreign_key: "region_id", dependent: :destroy

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
