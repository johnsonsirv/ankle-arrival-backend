class Api::V1::UsersController < ApplicationController
  before_action :set_appointment, only: [:appointments, :appointment]
  skip_before_action :authorize_api_request, only: :create

  def create
    user = User.create!(user_params)
    token = JsonWebToken.encode(payload: { user_id: user.id}) # JWT service
    response = { message: Message.signup_successful, token: token }
    json_response(response, :created)
  end

  def appointments
    json_response(@user_with_appointment.all_appointments)
  end

  def appointment
    json_response(@user_with_appointment
      .all_appointments
      .find(params[:id]))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @user_with_appointment = current_user # based on decoded token
    end

    def user_params
      params.permit(:username, :email, :city,
                    :firstname, :lastname, :password)
    end
end
