# frozen_string_literal: true

class Atc::Position < ApplicationRecord
  audited

  include ActiveModel::Validations
  validates_with FrequencyValidator

  # ActiveRecord validations
  validates :name,
            presence:     true,
            allow_blank:  false,
            uniqueness:   false

  validates :callsign,
            presence:     true,
            allow_blank:  false,
            uniqueness:   false

  validates :callsign_prefix,
            presence:     true,
            allow_blank:  false,
            uniqueness:   false,
            length:       { is: 3 }

  validates :sector_id,
            presence:     true,
            allow_blank:  true,
            uniqueness:   false,
            length:       { maximum: 3 }

  validates :callsign_suffix,
            presence:     true,
            allow_blank:  false,
            uniqueness:   false,
            length:       { is: 3 },
            inclusion:    { in: ["DEL", "GND", "TWR", "APP", "DEP", "CTR", "FSS"] }

  validates :frequency,
            :frequency,
            presence:     true,
            allow_blank:  false,
            uniqueness:   false

  validates :designated,
            inclusion: { in: [true, false] }

  validates :primary,
            inclusion: { in: [true, false] }

  validates :sortorder,
            presence:     true,
            allow_blank:  false,
            uniqueness:   false

  validates :visible,
            inclusion: { in: [true, false] }
end
