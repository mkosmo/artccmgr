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

  # ActiveRecord validations
  validate :permit_not_passed
  validate :permit_only_higher_rating
  validate :permit_only_one

  # ActiveRecord scopes
  scope :pending, -> do
    left_outer_joins(:result).where(
      training_ots_results: { recommendation_id: nil }
    )
  end

  private

    # Validates that no additional recommendations can be added
    # for a rating in which the user has successfully passed
    # an OTS
    #
    def permit_not_passed
      user.ots_results.each do |result|
        if result.rating == rating && result.pass?
          errors.add :rating, "already passed"
        end
      end
    end

    # Validates that no recommendations can be added for a lower
    # rating than the user currently has.
    #
    # This check is useful in addition to #permit_not_passed in the
    # event that an OTS was passed but the user's rating has not yet
    # been updated for some reason.
    #
    def permit_only_higher_rating
      if rating.vatsim_id < user.rating.vatsim_id
        errors.add :rating, "lower than user's current rating"
      end
    end

    # Validates that a user can have only one pending (uncompleted)
    # OTS recommendation at a time
    #
    def permit_only_one
      unless user.ots_recommendations.pending.empty?
        errors.add :user, "already has a pending OTS recommendation"
      end
    end
end
