# frozen_string_literal: true

class AuthenticateUser
  
  def initialize(username, password)
    @username = username
    @password = password
  end
  
  # service entry point
  def create
    #return a jwt if username
    jwt if user    
  end
  
  private
    attr_reader :username, :password
  
    def user
      user = User.find_by(username: username)
      return user if valid_login(user)
      raise ExceptionHandler::AuthenticationError
    end
  
    def valid_login(user)
      user && user.authenticate(password)
    end
  
    def jwt
      # call the JWT service here
      'RIGHJJ4H5534555'
    end
  
  
end