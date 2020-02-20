module Response
  
  def record_not_found
    { message: 'record not found', status_code: 400 }
  end
  
  def record_invalid
    { message: 'record invalid', status_code: :unprocessable_entity }
  end
  
  def json_response(object, status = :ok)
    render json: object, status: status
  end

end
