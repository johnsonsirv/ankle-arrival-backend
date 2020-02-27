module AuthorizationSpecHelper
  
  def token_generator(user_id)
    JsonWebToken.encode(payload: { user_id: user_id })
  end
  
  def expired_token_generator(user_id)
    expire = Time.now.to_i - 10
    p "sent#{$expire}"
    JsonWebToken.encode(payload: {user_id: user_id}, expire: expire)
  end
  
  
  def test_header(obj)
    test_token_headers = {
      expired_token: expired_token_generator(obj[:user_id]),
      invalid_token: token_generator(5),
      fake_token: 'faketoken',
      valid_token: token_generator(obj[:user_id])
    }
    test_token_headers[obj[:type]]
  end
  
  def fetch_mock_header(type)
    {
      'Authorization' => test_header(type)
      }
  end
end