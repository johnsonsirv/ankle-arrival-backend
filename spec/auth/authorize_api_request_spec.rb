require 'rails_helper'

RSpec.describe AuthorizeApiRequest do
  
  let(:user) { create(:user) }
  # set up mock headers
  let(:valid_header) { fetch_mock_header({ type: :valid_token, user_id: user.id }) }
  subject(:request_with_valid_token) { described_class.new(valid_header)}
  subject(:request_with_missing_token) { described_class.new({}) }
  
   let(:invalid_token_header) do
     fetch_mock_header({ type: :invalid_token, user_id: user.id })
   end
    subject(:request_with_invalid_token) { described_class.new(invalid_token_header) }
  
  let(:expired_token_header) do 
     fetch_mock_header({ type: :expired_token, user_id: user.id })
  end
        subject(:request_with_expired_token) { described_class.new(expired_token_header) }
   let(:fake_token_header) do 
      fetch_mock_header({ type: :fake_token, user_id: user.id })
   end
  subject(:request_with_fake_token) { described_class.new(fake_token_header) }
  
  describe '#create' do
    context 'valid request' do
      it 'returns a valid user' do
        result = request_with_valid_token.create
        expect(result[:user]).to eq(user)
      end
    end
    
    context 'invalid request' do
      it 'raises an invalid token error' do
        expect { request_with_invalid_token.create }
          .to raise_error(ExceptionHandler::InvalidToken)
      end
      it 'raises missing token error' do
        expect { request_with_missing_token.create }
          .to raise_error(ExceptionHandler::MissingToken)        
      end
      it 'raises expired token error' do
        expect { request_with_expired_token.create }
          .to raise_error(ExceptionHandler::ExpiredSignature)
      end
      
      it 'raises error on fake token' do
        expect { request_with_fake_token.create }
          .to raise_error(ExceptionHandler::InvalidToken)
      end

    end

  end

end
