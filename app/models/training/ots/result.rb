# frozen_string_literal: true

class Training::Ots::Result < ApplicationRecord
  # Audit configuration
  audited

  # ActiveRecord associations
  belongs_to :recommendation, class_name: "Training::Ots::Recommendation"
  belongs_to :instructor,     class_name: "User"
  belongs_to :session,        dependent:  :destroy

  has_one :user,   through: :recommendation
  has_one :rating, through: :recommendation

  # ActiveRecord validations
  validates :recommendation, uniqueness: true
  validates :session, presence: true, allow_blank: false

  validates_associated :session
end
