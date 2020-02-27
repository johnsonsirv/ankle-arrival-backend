# frozen_string_literal: true

class JsonWebToken
  
  HMAC_SECRET = Rails.application.credentials.secret_key_base
    
  def self.encode(payload:, expire: 24.hours.from_now)
    p "rec#{expire}"
    payload[:expire] = expire.to_i
    JWT.encode(payload, HMAC_SECRET)
  end
  
   def self.decode(token)
    decoded = JWT.decode(token, HMAC_SECRET)[0]
    HashWithIndifferentAccess.new decoded
    
    rescue JWT::DecodeError => e
      raise (ExceptionHandler::InvalidToken)
   end

end
