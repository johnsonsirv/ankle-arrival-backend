require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'Api::V1::Users API', type: :request, swagger_doc: 'v1/swagger.yaml' do
  let!(:users) { create_list(:user, 10) }
  let(:first_user_id) { users.first.id }
  let!(:appointments) do
    create_list(:appointment, 10,
                user: users.first)
  end
  let(:appointment_id) { appointments.first.id }
  let(:valid_signup_credential) { attributes_for(:user) }

  path '/users/{user_id}/appointments' do
    get 'Retrieves a list of users\'s appointments' do
      tags 'User'
      produces 'application/json'
      security [JWT: {}]
      parameter name: :user_id, in: :path, type: :integer,
                description: 'retrieve all appointments belonging to this user',
                required: true

     
      response 200, 'user appointments found' do
         let(:'Authorization') { "Bearer #{token_generator(first_user_id)}" }
        let(:user_id) { first_user_id }

        schema type: 'array',
               items: { '$ref' => '#/definitions/appointment' },
               required: %w[id username email firstname lastname doctor_firstname
                            doctor_lastname doctor_email date_of_appointment
                            time_of_appointment description]

        run_test! do |_response|
          expect(json).not_to be_empty
          expect(json[0]['username']).to eq(users.first.username)
          expect(json[0]['doctor_firstname']).not_to be_empty
        end
      end

      response 422, 'record not found' do
        let(:'Authorization') { "Bearer #{token_generator(50)}" }
        let(:user_id) { 50 }
        schema '$ref' => '#/definitions/not_found_error'
        run_test! do |response|
          expect(response.body).to match(/invalid token/i)
        end
      end
    end
  end

  path '/users/{user_id}/appointments/{id}' do
    get 'Retrieves a single user\'s appointment' do
      tags 'User'
      produces 'application/json'
      security [JWT: {}]
      parameter name: :user_id, in: :path, type: :integer,
                description: 'the user\'s id',
                required: true
      parameter name: :id, in: :path, type: :integer,
                description: 'appointment id belonging to user',
                required: true

      let(:user_id) { first_user_id }
      let(:id) { appointment_id }

      response 200, 'user\'s appointment found' do
         let(:'Authorization') { "Bearer #{token_generator(first_user_id)}" }
        schema '$ref' => '#/definitions/appointment',
               required: ['id', 'username', 'email', 'doctor_firstname',
                          'doctor_lastname', 'doctor_email', 'date_of_appointment',
                          'time_of_appointment', 'description']

        run_test! do |_response|
          expect(json).not_to be_empty
          expect(json['username']).to eq(users.first.username)
          expect(json['doctor_firstname']).not_to be_empty
        end
      end

      response 422, 'record not found' do
         let(:'Authorization') { "Bearer #{token_generator(50)}" }
        let(:user_id) { 50 }
        schema '$ref' => '#/definitions/not_found_error'
        run_test! do |response|
          expect(response.body).to match(/invalid token/i)
        end
      end
    end
  end

  # User signup
  path '/users/signup' do
    post 'User signup' do
      tags 'Auth'
      consumes 'application/json'
      parameter name: :credential, in: :body,
                schema: {
                  type: :object,
                  description: 'user signup credential',
                  properties: {
                    username: { type: 'string' },
                    email: { type: 'string' },
                    city: { type: 'string' },
                    firstname: { type: 'string' },
                    lastname: { type: 'string' },
                    password: { type: 'string' }
                  },
                  required: ['username', 'email', 'city', 'firstname', 'lastname', 'password']
                }

      response 201, 'signup successful' do
        let(:credential) { valid_signup_credential }

        examples 'application/json' => {
          username: 'john123',
          email: 'johnnny@kok.io',
          city: 'LA',
          firstname: 'john',
          lastname: 'harry',
          password: 'foobar'
        }

        run_test! do |_response|
          # test it returns a jwt
          expect(json['token']).not_to be_nil
          expect(json['message']).to match(/signup successful/)
        end
      end

      response 422, 'invalid request' do
        let(:credential) { {} }
        schema '$ref' => '#/definitions/invalid_request_error'
        run_test! do |response|
          expect(response.body).to match(/invalid request/i)
        end
      end
    end
  end
end
