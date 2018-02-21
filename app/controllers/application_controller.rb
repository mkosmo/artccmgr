# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  after_action :verify_authorized, unless: :devise_controller?
  protect_from_forgery with: :exception
end
