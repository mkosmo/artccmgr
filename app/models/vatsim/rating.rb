# frozen_string_literal: true

class Vatsim::Rating < ApplicationRecord
  # Audit configuration
  audited

  # ActiveRecord associations
  has_many :users, dependent: :destroy

  has_many :ots_recommendations,
           class_name:  "Training::Ots::Recommendation",
           foreign_key: "rating_id",
           dependent:   :destroy

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

  # Displays the name and short_name
  #   Tower Trainee (S1)
  def to_s
    "#{name} (#{short_name})"
  end
end
