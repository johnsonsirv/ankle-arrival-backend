require 'rails_helper'

RSpec.describe 'Api::V1::Authentication API', type: :request, swagger_doc: 'v1/swagger.yaml' do
  let!(:user) { create(:user) }
  let(:valid_login_credential) do
    {
      username: user.username,
      password: user.password
    }
  end
  let(:invalid_login_credential) do
    {
      username: Faker::Internet.username,
      password: Faker::Internet.password
    }
  end

  path '/auth/login' do
    post 'User Login' do
      tags 'Auth'
      consumes 'application/json'
      parameter name: :credential, in: :body,
                schema: {
                  type: :object,
                  description: 'user login credential',
                  properties: {
                    username: { type: 'string' },
                    password: { type: 'string' }
                  },
                  required: ['username', 'password']
                }

      response 200, 'authentication successful' do
        let(:credential) { valid_login_credential }

        examples 'application/json' => {
          username: 'john123',
          password: 'foobar'
        }

        run_test! do |_response|
          # test it returns a jwt
          expect(json['token']).not_to be_nil
        end
      end

      response 401, 'unauthorized access' do
        let(:credential) { invalid_login_credential }
        schema '$ref' => '#/definitions/invalid_request_error'
        run_test! do |response|
          expect(response.body).to match(/unauthorized access/i)
        end
      end
    end
  end
end
