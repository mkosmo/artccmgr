# frozen_string_literal: true

class Vatsim::Facility < ApplicationRecord
  audited associated_with: :division
  belongs_to :division, class_name: "Vatsim::Division"
  delegate :region, to: :division
end
