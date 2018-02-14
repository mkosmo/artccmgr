# frozen_string_literal: true

class Vatsim::Region < ApplicationRecord
  audited
  has_many :divisions, foreign_key: "region_id", dependent: :destroy
end
