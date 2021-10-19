module Exceptions
  class BaseException < StandardError
    include ActiveModel::Serialization
    attr_reader :status, :code, :message

    ERROR_DESCRIPTION = Proc.new {|code, message| {status: "error | failure", code: code, message: message}}

    ERROR_CODE_MAP = {
      "BookError::MissingSearchTerms" =>
        ERROR_DESCRIPTION.call(1000, "Can't find books without search terms"),
      "HttpartyError::NoResponse" =>
        ERROR_DESCRIPTION.call(2000, "Couldn't get any response from the server"),
      "HttpartyError::NotFound" =>
        ERROR_DESCRIPTION.call(2001, "Request couldn't be found"),
      "HttpartyError::SomethingWentWrong" =>
        ERROR_DESCRIPTION.call(2002, "Ooopss.... something went wrong"),
      "FriendError::MissingSearchTerms" =>
        ERROR_DESCRIPTION.call(3000, "Can't find friends without search terms"),
      "FriendError::SomethingWentWrong" =>
        ERROR_DESCRIPTION.call(3001, "Ooopss.... something went wrong")
    }

    def initialize
      api_errors()
      service_errors()
    end

    private
    def api_errors
      error_type = self.class.name.scan(/ApiExceptions::(.*)/).flatten.first
      Exceptions::BaseException::ERROR_CODE_MAP
        .fetch(error_type, {}).each do |attr, value|
          instance_variable_set("@#{attr}".to_sym, value)
      end
    end

    def service_errors
      error_type = self.class.name.scan(/ServiceExceptions::(.*)/).flatten.first
      Exceptions::BaseException::ERROR_CODE_MAP
        .fetch(error_type, {}).each do |attr, value|
          instance_variable_set("@#{attr}".to_sym, value)
      end
    end
  end
end