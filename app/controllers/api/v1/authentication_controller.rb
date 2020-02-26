class Api::V1::AuthenticationController < ApplicationController
  def create
    # if the user authentication is successful, return a jwt
    login_attempt = AuthenticateUser.new(auth_params[:username], auth_params[:password])
    token = login_attempt.create
    json_response(token: token)
  end

  private

  def auth_params
    params.permit(:username, :password)
  end
end
