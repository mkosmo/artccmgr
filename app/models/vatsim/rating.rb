# frozen_string_literal: true

class Vatsim::Rating < ApplicationRecord
  # Audit configuration
  audited

  # ActiveRecord associations
  has_many :users, dependent: :destroy
  has_many :training_blocks, class_name: "Training::Block", dependent: :destroy

  # ActiveRecord validations
  validates :name,
            presence:     true,
            allow_blank:  false,
            uniqueness:   { case_sensitive: false }

  validates :short_name,
            presence:     true,
            allow_blank:  false,
            length:       { maximum: 3 },
            uniqueness:   { case_sensitive: false }
  validates :vatsim_id,
            presence:     true,
            allow_blank:  false,
            uniqueness:   true,
            inclusion:    { in: 0..100 }
end
