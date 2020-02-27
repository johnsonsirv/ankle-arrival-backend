module Response
  
  def record_not_found
    { message: 'record not found', status_code: :not_found }
  end
  
  def record_invalid
    { message: 'invalid request', status_code: :unprocessable_entity }
  end
  
  def unauthorized
    { message: 'unauthorized access', status_code: :unauthorized }
  end
  
  def invalid_token
    { message: 'invalid token', status_code: :unprocessable_entity }
  end
  
  def missing_token
    { message: 'missing token', status_code: :unprocessable_entity }
  end
  
  def json_response(object, status = :ok)
    render json: object, status: status
  end
  
 

end
