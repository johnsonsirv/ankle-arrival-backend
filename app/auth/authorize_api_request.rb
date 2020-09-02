# frozen_string_literal: true

class AuthorizeApiRequest
  
  def initialize(headers = {})
    @headers = headers  
  end

  def create
    {
      user: user  
    }
  end
  
  private
    attr_reader :headers
  
    def user
      # attempt to find the user based on user_id from decoded jwt
      # memoize the user
      @user ||= User.find(decoded_token[:user_id]) if decoded_token
      rescue ActiveRecord::RecordNotFound => e
        raise( ExceptionHandler::InvalidToken )
    end
    
    def decoded_token
      @decoded_token ||= JsonWebToken.decode(recieved_headers)
    end
  
    def recieved_headers
      raise(ExceptionHandler::MissingToken) unless headers['Authorization'].present?
      
      # get the jwt from the authorization e.g Authorization: Bearer xxx.yyy.zzz
      headers['Authorization'].split(' ').last
    end
end
