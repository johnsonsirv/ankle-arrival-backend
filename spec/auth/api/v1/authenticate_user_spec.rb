require 'rails_helper'

# test the service class
RSpec.describe AuthenticateUser do
  let(:user) { create(:user) }
  subject(:valid_login) { described_class.new(user.username, user.password) }
  subject(:invalid_login) { described_class.new('wrong username', 'wrong password') }

  describe 'create' do
    context 'valid login credential' do
      it 'returns an auth token' do
        token = valid_login.create
        expect(token).not_to be_nil
      end
    end

    context 'invalid login credential' do
      it 'raises an authentication error' do
        expect { invalid_login.create }.to raise_error(
          ExceptionHandler::AuthenticationError
        )
      end
    end
  end
end
