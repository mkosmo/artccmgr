# frozen_string_literal: true

class Training::Type < ApplicationRecord
  # Audit configuration
  audited

  # ActiveRecord associations
  has_many :sessions, dependent: :nullify

  # ActiveRecord validations
  validates :name,
            presence:     true,
            allow_blank:  false,
            uniqueness:   { case_sensitive: false }

  # Returns the name of the Training Type
  def to_s
    name
  end
end
