# frozen_string_literal: true

module ApplicationHelper
  # Returns the configured setting for the site slogan
  #
  def site_slogan
    Setting.find_by(key: "frontend").value["slogan"]
  end

  # Returns the configured setting for the site title
  #
  def site_title
    Setting.find_by(key: "frontend").value["title"]
  end
end
