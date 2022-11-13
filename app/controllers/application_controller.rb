# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(_resource)
    books_url
  end

  def after_sign_out_path_for(_resource)
    '/users/sign_in'
  end

  private

  def configure_permitted_parameters
    keys = [:postalcode, :address, :self_introduction]
    devise_parameter_sanitizer.permit(:account_update, keys: keys)
  end
end
