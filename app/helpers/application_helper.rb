# frozen_string_literal: true

module ApplicationHelper
  # Returns the facility ident
  #
  def facility_ident
    Setting.find_by(key: "facility").value["ident"]
  end

  # Returns the configured setting for the site title
  #
  def facility_name
    Setting.find_by(key: "facility").value["name"]
  end

  # Returns the configured setting for the site slogan
  #
  def facility_slogan
    Setting.find_by(key: "facility").value["slogan"]
  end
end
