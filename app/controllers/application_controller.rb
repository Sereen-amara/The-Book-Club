class ApplicationController < ActionController::Base
  # Redirect to showcase page after login
  def after_sign_in_path_for(resource)
    showcase_path
  end
end
