# frozen_string_literal: true

class Api::V1::AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:update, :destroy]

  # POST /api/v1/appointments
  def create
    request = current_user.appointments.build(appointment_params)
    return json_response(request) if request.save

    raise(ActiveRecord::RecordInvalid)
  end

  # PATCH/PUT /api/v1/appointments/1
  def update
    @appointment.update(appointment_params)
    json_response(@appointment)
  end

  # DELETE /api/v1/appointments/1
  def destroy; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def appointment_params
    params.permit(:doctor_id, :description, :appointment_date, :appointment_time)
  end
end
