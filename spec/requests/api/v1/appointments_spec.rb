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
      tags 'User'
      consumes 'application/json'
      security [JWT: {}]
      parameter name: :appointment, in: :body,
                schema: {
                  type: :object,
                  description: 'a new appointment param to be added',
                  properties: {
                    doctor_id: { type: 'integer' },
                    description: { type: 'string' },
                    appointment_date: { type: 'string' },
                    appointment_time: { type: 'string' }
                  },
                  required: ['doctor_id', 'description', 'appointment_date', 'appointment_time']
                }

      let(:'Authorization') { "Bearer #{token_generator(users.first.id)}" }

      response 200, 'new appointment created' do
        let(:appointment) { valid_attributes }
        examples 'application/json' => {
          doctor_id: 2,
          description: 'This is my first appointment',
          appointment_date: Date.today.next_month.to_s,
          appointment_time: Time.now.to_s
        }

        run_test! do |_response|
          expect(json).not_to be_empty
          expect(json['description']).to eq(valid_attributes.description)
        end
      end

      response 422, 'invalid request' do
        let(:appointment) { invalid_attributes }
        schema '$ref' => '#/definitions/invalid_request_error'
        run_test! do |response|
          expect(response.body).to match(/invalid request/i)
        end
      end
    end
  end

  # PUT to update appointments

  path '/appointments/{id}' do
    put 'Update existing appointment' do
      tags 'User'
      consumes 'application/json'
      security [JWT: {}]
      parameter name: :id, in: :path, type: :integer,
                description: 'pass an id for the appointment', required: true
      parameter name: :appointment, in: :body,
                schema: {
                  type: :object,
                  description: 'appointment attributes to be updated',
                  properties: {
                    doctor_id: { type: 'integer' },
                    description: { type: 'string' },
                    appointment_date: { type: 'string' },
                    appointment_time: { type: 'string' }
                  }
                }

      let(:'Authorization') { "Bearer #{token_generator(users.first.id)}" }
      let(:valid_appointment) { create(:appointment, doctor: doctors.first, user: users.second) }

      response 200, 'appointment updated' do
        let(:id) { valid_appointment.id }
        let(:appointment) { { description: 'This description was updated' } }

        run_test! do |_response|
          expect(json).not_to be_empty
          expect(json['description']).to eq(appointment[:description])
        end
      end

      response 404, 'record not found' do
        let(:id) { 50 }
        let(:appointment) { { description: 'This description was updated' } }
        schema '$ref' => '#/definitions/not_found_error'
        run_test! do |response|
          expect(response.body).to match(/record not found/i)
        end
      end
    end
  end
end
