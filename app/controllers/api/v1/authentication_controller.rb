class Api::V1::AuthenticationController < ApplicationController
  skip_before_action :authorize_api_request, only: :create

  def create
    # if the user authentication is successful, return a jwt
    login_attempt = AuthenticateUser.new(auth_params[:username], auth_params[:password])
    token = login_attempt.create
    response = { token: token, username: auth_params[:username] }
    json_response(response)
  end

  private

  def auth_params
    params.permit(:username, :password)
  end
end
