# frozen_string_literal: true

class AuthenticateUser
  def initialize(username, password)
    @username = username.downcase
    @password = password
  end

  # service entry point
  def create
    # return a jwt if username
    jwt if user
  end
 
  private

  attr_reader :username, :password

  def user
    user = User.find_by(username: username)
    
     # raise an exception is user authenticated via oauth attempts normal login
    raise ExceptionHandler::AuthenticationError if user &&
      (user.uid || user.provider)
    
    return user if valid_login(user)

    raise ExceptionHandler::AuthenticationError
  end
  

  def valid_login(user)
    user&.authenticate(password)
  end

  def jwt
    # call the JWT service here
    JsonWebToken.encode(payload: { user_id: user.id})
  end
end
