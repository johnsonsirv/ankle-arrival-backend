require 'rails_helper'
# require "#{::Rails.root}/spec/support/request_spec_helper.rb"

RSpec.describe 'Api::V1::Doctors', type: :request do
  
  let!(:doctors) { create_list(:doctor, 10) }
  let(:doctor_id) { doctors.first.id }
  let(:api_url) { '/api/v1/'}
  
  describe 'GET /api/v1/doctors' do
    before { get "#{api_url}/doctors" }
    it 'return doctors' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
  
   describe 'GET /api/v1/doctors/:id' do
    before { get "#{api_url}/doctors/#{doctor_id}" }
    
     context 'when the record exists' do
        it 'returns doctor information' do
          expect(json).not_to be_empty
          expect(json['id']).to eq(doctor_id)
        end
        it 'return status code 200' do
          expect(response).to have_http_status(200)
        end
     end
     
     context 'when the record does not exists' do
       let(:doctor_id) { 50 }
       
        it 'returns status code 400' do
          expect(response).to have_http_status(400)
        end
        it 'returns a not found message' do
          expect(response.body).to match(/record not found/i)
        end
     end
  end
  
end
