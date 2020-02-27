require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
 
  describe '#athorize_api_request' do
    let!(:user) { create(:user) }
    let(:valid_header) { fetch_mock_header({ type: :valid_token, user_id: user.id }) }
    let(:invalid_header) { fetch_mock_header({ type: :missing_token, user_id: user.id }) }
    
    it { should use_before_action(:authorize_api_request) }
    context 'with token provided in request headers' do
      before do
        allow(request).to receive(:headers).and_return(valid_header)
      end
      it 'sets the current user when valid' do
        expect(subject.instance_eval { authorize_api_request }).to eq(user)
      end
    end
    context 'missing token or invalid token in request headers' do
       before do
        allow(request).to receive(:headers).and_return(invalid_header)
      end
      it 'raises missing token error' do
         expect {subject.instance_eval { authorize_api_request } }
          .to raise_error(ExceptionHandler::MissingToken)
      end
    end
    
  end
  
end