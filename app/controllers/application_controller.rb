class ApplicationController < ActionController::Base
    before_action :authenticate_user!

    def show_errors(status, error_code, extra = {})
        @errors = []
        status = Rack::Utils::SYMBOL_TO_STATUS_CODE[status] if status.is_a? Symbol

        error = {
            title: I18n.t("error_messages.#{error_code}.title"),
            status: status,
            code: I18n.t("error_messages.#{error_code}.code")
        }.merge(extra)
    
        detail = I18n.t("error_messages.#{error_code}.detail", default: '')
        error[:detail] = detail unless detail.empty?
        @errors.append(error)
        render_errors
    end

    private 

    def render_errors 
        respond_to do |format|
            format.js { render partial: 'books/error' }
        end
    end
end
