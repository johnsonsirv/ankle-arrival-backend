module ExceptionHandler
  
  # use the included method to load Response module
  extend ActiveSupport::Concern
  
  # inherit from StandardError
  class AuthenticationError < StandardError; end

  included do
    rescue_from ExceptionHandler::AuthenticationError do |e|
      json_response({ message: unauthorized[:message] },
        unauthorized[:status_code])
    end
    
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: record_not_found[:message] },
        record_not_found[:status_code])
    end
    
    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ message: record_invalid[:message] },
        record_invalid[:status_code])
    end
  end
end