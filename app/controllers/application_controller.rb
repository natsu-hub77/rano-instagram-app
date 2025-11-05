class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :update_last_seen_at, if: :user_signed_in?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:account_name])
  end

  private
    def update_last_seen_at
      if current_user.last_seen_at.nil? || current_user.last_seen_at < 1.minute.ago
        current_user.update_column(:last_seen_at, Time.current)
      end
    end
end
