# frozen_string_literal: true

class Vatsim::Facility < ApplicationRecord
  # Audit configuration
  audited associated_with: :division

  # ActiveRecord associations
  belongs_to :division, class_name: "Vatsim::Division"
  has_many   :users,    dependent: :nullify

  # ActiveRecord delegations
  delegate :region, to: :division

  # ActiveRecord validations
  validates :name,
            presence:     true,
            allow_blank:  false,
            uniqueness:   { case_sensitive: false }

  validates :shortname,
            presence:     true,
            allow_blank:  false,
            length:       { maximum: 4 },
            uniqueness:   { case_sensitive: false }
end
