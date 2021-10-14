class ApplicationController < ActionController::Base
    before_action :authenticate_user!

    def render_error_response(error)
        @error = error 
        respond_to do |format|
            format.js { render partial: 'books/api_error' }
        end
        #render json: error, serializer: ApiExceptions::ApiExceptionSerializer, status: 200
      end

    # def format_error(status, error_code, extra = {})
    #     @errors = []
    #     status = Rack::Utils::SYMBOL_TO_STATUS_CODE[status] if status.is_a? Symbol

    #     error = {
    #         title: I18n.t("error_messages.#{error_code}.title"),
    #         status: status,
    #         code: I18n.t("error_messages.#{error_code}.code")
    #     }.merge(extra)
    
    #     detail = I18n.t("error_messages.#{error_code}.detail", default: '')
    #     error[:detail] = detail unless detail.empty?
    #     @errors.append(error)
    #     render_error()
    # end

    # private 

    # def render_error
    #     respond_to do |format|
    #         format.js { render partial: 'books/api_error' }
    #     end
    # end
end
