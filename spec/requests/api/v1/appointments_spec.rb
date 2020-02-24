require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'Api::V1::Appointments API', type: :request, swagger_doc: 'v1/swagger.yaml' do
  
  # POST to add appointment
  let!(:doctors) { create_list(:doctor, 10) }
  let!(:users) { create_list(:user, 10) }
  let(:valid_attributes) { build(:appointment, doctor: doctors.first, user: users.second) }
  let(:invalid_attributes) { build(:appointment, doctor: nil, user: nil) }

  path '/appointments' do
    post 'Create a new appointment' do
      tags   'User'
      consumes 'application/json'
      parameter name: :appointment, in: :body,
      schema: { 
        user_id: { type: 'integer' },
        doctor_id: { type: 'integer' },
        description: { type: 'string' },
        appointment_date: { type: 'string' },
        appointment_time: { type: 'string' }
      },
      description: 'a new appointment param to be added',
      required: ['user_id', 'doctor_id', 'description', 'appointment_date', 'appointment_time']
      
       

      response 200, 'new appointment created' do
        let(:appointment) { valid_attributes }
        examples 'application/json' => {
          user_id: 1,
          doctor_id: 2,
          description: 'This is my first appointment',
          appointment_date: "#{Date.today.next_month}",
          appointment_time: "#{Time.now}"
        }
        
        run_test! do |response|
          expect(json).not_to be_empty
          expect(json['description']).to eq(valid_attributes.description)
        end
      end
      
      response 422, 'invalid request' do
       let(:appointment) {  invalid_attributes }
        schema '$ref' => '#/definitions/invalid_request_error'
        run_test! do |response|
           expect(response.body).to match(/invalid request/i)
        end
      end
            
    end
  end
  
  # PUT to update appointments
  
  
end
