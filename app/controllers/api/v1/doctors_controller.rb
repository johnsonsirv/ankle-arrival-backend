class Api::V1::DoctorsController < ApplicationController
  before_action :get_doctor, only: [:show, :update, :destroy]
  before_action :get_appointment, only: [:appointments, :appointment]

  # GET /api/v1/doctors
  def index
    @doctors = Doctor.all
    json_response(@doctors)
  end

  # GET /api/v1/doctors/1
  def show
    json_response(@doctor)
  end
  
  # GET /api/v1/doctors/:id/appointments
  def appointments
    json_response(@doctor_with_appointment.all_appointments)
  end
  
  # GET /api/v1/doctors/:id/appointments/:id
  def appointment
    json_response(@doctor_with_appointment
      .all_appointments
      .find(params[:id]))
  end


  # POST /api/v1/doctors
  def create
   
  end

  # PATCH/PUT /api/v1/doctors/1
  def update
   
  end

  # DELETE /api/v1/doctors/1
  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def get_doctor
      @doctor = Doctor.find(params[:id])
    end
  
    def get_appointment
      @doctor_with_appointment = Doctor.find(params[:doctor_id])
    end

    # Only allow a trusted parameter "white list" through.
    def api_v1_doctor_params
      params.fetch(:api_v1_doctor, {})
    end
end
