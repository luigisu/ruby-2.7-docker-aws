require 'ruby-oci8'
require 'ruby-plsql'
require 'pg'
require 'sequel'
# require 'sinatra'
def lambda_handler(event:, context:)
  # TODO implement
  p "hola"
  { statusCode: 200, body: JSON.generate('Hello from Lambda!') }
end
