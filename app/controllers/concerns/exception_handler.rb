module ExceptionHandler
  
  # use the included method to load Response module
  extend ActiveSupport::Concern
  
  # inherit from StandardError
  class AuthenticationError < StandardError; end
  class InvalidToken < StandardError; end
  class MissingToken < StandardError; end

  included do
    rescue_from ExceptionHandler::AuthenticationError do |e|
      json_response({ message: unauthorized[:message] },
        unauthorized[:status_code])
    end
    
    rescue_from ExceptionHandler::InvalidToken do |e|
      json_response({ message: invalid_token[:message] },
        invalid_token[:status_code])
    end
    
    rescue_from ExceptionHandler::MissingToken do |e|
      json_response({ message: missing_token[:message] },
        missing_token[:status_code])
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
