class Api::V1::AuthenticationController < ApplicationController
  skip_before_action :authorize_api_request, only: [:create, :oauth]

  def create
    # if the user authentication is successful, return a jwt
    login_attempt = AuthenticateUser.new(auth_params[:username], auth_params[:password])
    token = login_attempt.create
    response = { token: token, username: auth_params[:username] }
    json_response(response)
  end
  
  def oauth
    @user = User.from_oauth(oauth_params)
    jwt if @user
  end

  private
  
  def jwt
    token = JsonWebToken.encode(payload: { user_id: @user.id})
    response = { token: token, username: oauth_params[:username] }
    json_response(response)
  end

  def auth_params
    params.permit(:username, :password)
  end
  
  def oauth_params
    params.permit(:username, :email, :city,
                  :firstname, :lastname, 
                  :password, :provider, :token)
  end
end
