# frozen_string_literal: true

# Describes a block of training
#
class Training::Block < ApplicationRecord
  # Audit configuration
  audited

  # ActiveRecord associations
  belongs_to :rating,   class_name: "Vatsim::Rating", optional: true
  has_many   :progress, class_name: "Training::Progress", dependent: :destroy
  has_many   :users,  through: :progress, class_name: "Training::Progress"

  has_many   :sessions, through: :progress

  # ActiveRecord validations
  validates :name, presence: true, allow_blank: false

  validates :order,
            presence:     true,
            allow_blank:  false,
            numericality: { greater_than_or_equal_to: 1 },
            uniqueness:   { scope: :rating }
end
