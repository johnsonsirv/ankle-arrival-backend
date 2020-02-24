class Api::V1::UsersController < ApplicationController
  before_action :get_appointment, only: [:appointments, :appointment]
  
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
     def get_appointment
      @user_with_appointment = User.find(params[:user_id])
    end
end
