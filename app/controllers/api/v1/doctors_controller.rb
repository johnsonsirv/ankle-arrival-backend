class Api::V1::DoctorsController < ApplicationController
  before_action :get_doctor, only: [:show, :update, :destroy]

  # GET /api/v1/doctors
  def index
    @doctors = Doctor.all
    json_response(@doctors)
  end

  # GET /api/v1/doctors/1
  def show
    json_response(@doctor)
  end

  # POST /api/v1/doctors
  def create
    @api_v1_doctor = Api::V1::Doctor.new(api_v1_doctor_params)

    if @api_v1_doctor.save
      render json: @api_v1_doctor, status: :created, location: @api_v1_doctor
    else
      render json: @api_v1_doctor.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/doctors/1
  def update
    if @api_v1_doctor.update(api_v1_doctor_params)
      render json: @api_v1_doctor
    else
      render json: @api_v1_doctor.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/doctors/1
  def destroy
    @api_v1_doctor.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def get_doctor
      @doctor = Doctor.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def api_v1_doctor_params
      params.fetch(:api_v1_doctor, {})
    end
end
