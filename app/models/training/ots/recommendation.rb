# frozen_string_literal: true

class Training::Ots::Recommendation < ApplicationRecord
  # Audit configuration
  audited

  # ActiveRecord associations
  belongs_to :user
  belongs_to :instructor, class_name: "User"
  belongs_to :rating,     class_name: "Vatsim::Rating"

  has_one :result,
          class_name: "Training::Ots::Result",
          dependent:  :destroy

  scope :pending, -> do
    left_outer_joins(:result).where(
        training_ots_results: {recommendation_id: nil}
    )
  end
end
