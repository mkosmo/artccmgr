# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    authorize :home, :index?
  end
end
