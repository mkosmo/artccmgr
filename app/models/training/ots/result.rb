# frozen_string_literal: true

class Training::Ots::Result < ApplicationRecord
  # Audit configuration
  audited

  # ActiveRecord associations
  belongs_to :recommendation, class_name: "Training::Ots::Recommendation"
  belongs_to :instructor, class_name: "User"

  has_one :user, through: :recommendation

  # ActiveRecord validations
  validates :recommendation, uniqueness: true
  validates :comments, presence: true, allow_blank: false
end
