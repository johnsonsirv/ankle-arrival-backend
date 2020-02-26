require 'rails_helper'
require 'swagger_helper'

describe 'Api::V1::Doctors API', type: :request, swagger_doc: 'v1/swagger.yaml' do
  
  let!(:doctors) { create_list(:doctor, 10) }
  let(:first_doctor_id) { doctors.first.id }

  path '/doctors' do
    get 'Retrieves a list of doctors' do
      tags   'User'
      produces 'application/json'      
      response 200, 'returns list of doctors' do
        examples 'application/json' => {
          id: 1,
          firstname: 'Jerry',
          lastname: 'Christian',
          email: 'jerry.c@bco.com',
          username: 'jerryC123',
          city: 'LA'
        }
        schema type: 'array',
          items: { '$ref' => '#/definitions/doctor' },
          required: [ 'id', 'username', 'email', 'firstname', 'lastname', 'city' ]
        run_test! do |response|
          expect(json).not_to be_empty
          expect(json.size).to eq(10)
        end
      end
            
    end
  end
  
  path '/doctors/{id}' do
    get 'Retrieves a doctor' do
      tags   'User'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer,
      description: 'pass an id for the doctor', required: true

      response 200, 'doctor found' do
        let (:id) { first_doctor_id }
        schema '$ref' => '#/definitions/doctor',
          required: [ 'id', 'username', 'email', 'firstname', 'lastname', 'city' ]
        run_test! do |response|
          expect(json).not_to be_empty
          expect(json['id']).to eq(first_doctor_id)
        end
      end
      
      response 400, 'record not found' do
        let (:id) { 50 }
        schema '$ref' => '#/definitions/not_found_error'
        run_test! do |response|
           expect(response.body).to match(/record not found/i)
        end
      end
            
    end
  end
  
  path '/doctors/{doctor_id}/appointments' do
    get 'Retrieves a list of doctor\'s appointments' do
      tags   'Doctor'
      produces 'application/json'
      parameter name: :doctor_id, in: :path, type: :integer,
      description: 'retrieve all appointments belonging to this id',
      required: true
      
       let!(:appointments) { create_list(:appointment, 10,
        { doctor: doctors.first }) }

      response 200, 'doctor\'s appointments found' do
        let(:doctor_id) { first_doctor_id }

        schema type: 'array',
          items: { '$ref' => '#/definitions/appointment' },
          required: %w[id username email firstname lastname doctor_firstname
            doctor_lastname doctor_email date_of_appointment
            time_of_appointment description]
        
        run_test! do |response|
          expect(json).not_to be_empty
          expect(json[0]['doctor_firstname']).to eq(doctors.first.firstname)
          expect(json[0]['username']).not_to be_empty
        end
      end
      
      response 400, 'record not found' do
        let (:doctor_id) { 50 }
        schema '$ref' => '#/definitions/not_found_error'
        run_test! do |response|
           expect(response.body).to match(/record not found/i)
        end
      end
            
    end
  end
  
  path '/doctors/{doctor_id}/appointments/{id}' do
    get 'Retrieves a single doctor\'s appointment' do
      tags   'Doctor'
      produces 'application/json'
      parameter name: :doctor_id, in: :path, type: :integer,
      description: 'the doctor\'s id',
      required: true
      parameter name: :id, in: :path, type: :integer,
      description: 'retrieve a single appointment with id belonging to doctor',
      required: true
      
      let!(:appointments) { create_list(:appointment, 10,
        { doctor: doctors.first }) }
      let(:appointment_id) { appointments.first.id }
      let(:doctor_id) { first_doctor_id }
      let(:id) { appointment_id }

      response 200, 'doctor\'s appointment found' do
       
        schema '$ref' => '#/definitions/appointment',
          required: [ 'id', 'username', 'email', 'doctor_firstname',
            'doctor_lastname', 'doctor_email', 'date_of_appointment',
            'time_of_appointment', 'description']
        
        run_test! do |response|
          expect(json).not_to be_empty
          expect(json['doctor_firstname']).to eq(doctors.first.firstname)
          expect(json['username']).not_to be_empty
        end
      end
      
      response 400, 'record not found' do
        let (:doctor_id) { 50 }
        schema '$ref' => '#/definitions/not_found_error'
        run_test! do |response|
           expect(response.body).to match(/record not found/i)
        end
      end
            
    end
  end
  
end
