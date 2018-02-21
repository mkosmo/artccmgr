# frozen_string_literal: true

class Role < ApplicationRecord
  validates :name,
            presence:     true,
            allow_blank:  false,
            uniqueness:   { case_sensitive: false }
end
