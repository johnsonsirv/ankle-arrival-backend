require 'rails_helper'
require 'swagger_helper'

describe 'Api::V1::Doctors API', type: :request, swagger_doc: 'v1/swagger.yaml' do
  
  let!(:doctors) { create_list(:doctor, 10) }
  let(:doctor_id) { doctors.first.id }
  path '/doctors' do
    get 'Retrieves a list of doctors' do
      tags   'User'
      produces 'application/json'
      # parameter name: :city, in: :query, schema: { type: :string },
      # description: 'pass an optional city for looking up doctors in a city'
      # parameter name: :offset, in: :query, schema: { type: :integer },
      # description: 'optional number of pages to skip for pagination'
      # parameter name: :limit, in: :query, schema: { type: :integer },
      # description: 'maximum number of records to return',
      # minimum: 0,
      # maximum: 10
      
      response 200, 'returns list of doctors' do
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
      parameter name: :id, in: :path, schema: { type: :integer },
      description: 'pass an id for the doctor', required: true
      let (:id) { doctor_id }
      response 200, 'doctor found' do
        schema '$ref' => '#/definitions/doctor',
          required: [ 'id', 'username', 'email', 'firstname', 'lastname', 'city' ]
        run_test! do |response|
          expect(json).not_to be_empty
          expect(json['id']).to eq(doctor_id)
        end
      end
            
    end
  end
  
end
