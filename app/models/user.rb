# frozen_string_literal: true

class User < ApplicationRecord
  # Audit configuration
  audited

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :rememberable, :trackable

  # ActiveRecord associations
  belongs_to :facility, class_name: "Vatsim::Facility", optional: true
  belongs_to :rating, class_name: "Vatsim::Rating"

  # ActiveRecord validations
  validates :cid,
            presence:     true,
            allow_blank:  false,
            uniqueness:   true,
            numericality: { greater_than: 0 }

  validates :first_name,  presence: true, allow_blank: false
  validates :last_name,   presence: true, allow_blank: false
  validates :email,       presence: true, allow_blank: false
  validates :reg_date,    presence: true, allow_blank: false

  validates :initials, length: { maximum: 2 }

  # ActiveRecord delegations
  delegate :division, to: :facility
  delegate :region,   to: :division

  # Returns the full name of the user with rating:
  #   "John Smith (OBS)"
  #
  def to_s
    "#{first_name} #{last_name} (#{rating.short_name})"
  end
end
