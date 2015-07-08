class ApplicationController < ActionController::Base
  protect_from_forgery

  def angular
    render 'layouts/application'
  end
end
