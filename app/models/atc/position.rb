# frozen_string_literal: true

class Atc::Position < ApplicationRecord
  audited

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
            length:       { is: 3 }

  validates :frequency,
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


  # t.string :name, null: false
  # t.string :callsign, null: false
  # t.string :callsign_prefix, null: false, limit: 3
  # t.string :sector_id, limit: 3
  # t.string :callsign_suffix, null: false, limit: 3
  # t.decimal :frequency, null: false, default: 199.998
  # t.boolean :designated, null: false, default: false
  # t.boolean :primary, null: false, default: false
  # t.integer :sortorder
  # t.boolean :visible, null: false, default: false
end
