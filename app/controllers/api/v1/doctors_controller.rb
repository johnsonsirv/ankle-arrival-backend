class Api::V1::DoctorsController < ApplicationController
  before_action :get_doctor, only: [:show]
  before_action :get_appointment, only: [:appointments, :appointment]

  # GET /api/v1/doctors
  def index
    json_response(Doctor.all)
  end

  # GET /api/v1/doctors/1
  def show
    json_response(@doctor)
  end
  
  # GET /api/v1/doctors/1/appointments
  def appointments
    json_response(@doctor_with_appointment.all_appointments)
  end
  
  # GET /api/v1/doctors/1/appointments/2
  def appointment
    json_response(@doctor_with_appointment
      .all_appointments
      .find(params[:id]))
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def get_doctor
      @doctor = Doctor.find(params[:id])
    end
  
    def get_appointment
      @doctor_with_appointment = Doctor.find(params[:doctor_id])
    end

end
