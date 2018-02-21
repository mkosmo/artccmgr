# frozen_string_literal: true

module ApplicationHelper
  # Returns the facility ident
  #
  def facility_ident
    Setting.facility["ident"]
  end

  # Returns the configured setting for the site title
  #
  def facility_name
    Setting.facility["name"]
  end

  # Returns the configured setting for the site slogan
  #
  def facility_slogan
    Setting.facility["slogan"]
  end
end
