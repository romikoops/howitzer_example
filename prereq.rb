#require 'factory_girl/step_definitions'
require 'her'
require 'factory_girl'

class MyTokenAuthentication < Faraday::Middleware
  def call(env)
    env[:request_headers]["Authorization: Token token"] = "97f85fa997125c758a67213c44e1c0543a603f3819b31456b9"
    @app.call(env)
  end
end

Her::API.setup url: "http://demoapp.strongqa.com" do |c|
  # Request
  c.use MyTokenAuthentication
  c.use Faraday::Request::UrlEncoded

  # Response
  c.use Her::Middleware::DefaultParseJSON

  # Adapter
  c.use Faraday::Adapter::NetHttp
end

Dir["./prereq/models/**/*.rb"].each {|f| require f}

FactoryGirl.define do
  sequence :serial do
    a = [('a'..'z').to_a, (0..9).to_a].flatten.shuffle
    "#{Time.now.utc.strftime("%j%H%M%S")}#{a[0..4].join}"
  end
end

FactoryGirl.definition_file_paths = ['./prereq/factories']
FactoryGirl.find_definitions