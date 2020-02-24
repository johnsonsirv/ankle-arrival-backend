require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s
  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      swagger: '2.0',
      info: {
        title: 'Book Appointment API',
        version: 'v1',
        description: 'This API is a backend for a tablet web-app that will enable sports athletes(users) to book an appointment with a physiotherapist doctor'
      },
      paths: {},
      basePath: '/api/v1',
      definitions: {
        doctor: {
          type: 'object',
          properties: {
            id: { type: 'integer' },
            firstname: { type: 'string' },
            lastname: { type: 'string' },
            email: { type: 'string' },
            username: { type: 'string' },
            city: { type: 'string' }
          }
        },
        appointment: {
          type: 'object',
          properties: {
            id: { type: 'integer' },
            doctor_firstname: { type: 'string' },
            doctor_lastname: { type: 'string' },
            doctor_email: { type: 'string' },
            username: { type: 'string' },
            email: { type: 'string' },
            date_of_appointment: { type: 'string' },
            time_of_appointment: { type: 'string' },
            description: { type: 'string' }
          }
        },
        not_found_error: {
          type: 'object',
          properties: {
            message: {
              type: 'string'
            }
          }
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
  config.swagger_dry_run = false
end
