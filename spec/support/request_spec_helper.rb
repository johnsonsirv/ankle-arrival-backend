module RequestSpecHelper
  # parse the response  body to json
  def json
    JSON.parse(response.body)
  end
end