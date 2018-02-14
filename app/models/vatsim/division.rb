# frozen_string_literal: true

class Vatsim::Division < ApplicationRecord
  audited associated_with: :region
  belongs_to :region, class_name: "Vatsim::Region"
  has_many :artccs, foreign_key: "division_id", dependent: :destroy
end
