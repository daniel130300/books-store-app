class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?
    #before_action :require_shipping_address, unless: :devise_controller?
    before_action :require_shipping_address, unless: :devise_controller?


    def not_found
        raise ActionController::RoutingError.new('Not Found')
    rescue
        render_404
    end

    def render_404
        render :file => "#{Rails.root}/public/404.html",  :status => 404
    end

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:fullname, :birth_date, :avatar])
        devise_parameter_sanitizer.permit(:account_update, keys: [:fullname, :birth_date, :avatar])
    end

    private 

    def require_shipping_address
        if user_signed_in? && !current_user.admin && current_user.address.blank?
            flash[:alert] = "Before tou continue, please add your shipping address"
            redirect_to new_address_path
        end
    end
end
