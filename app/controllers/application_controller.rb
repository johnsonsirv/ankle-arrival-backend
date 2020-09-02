# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  
  before_action :authorize_api_request
  attr_reader :current_user
  
  def authorize_api_request
    @current_user = (AuthorizeApiRequest.new(request.headers).create)[:user]
  end
end
