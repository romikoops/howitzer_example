require 'factory_girl/step_definitions'

Her::API.setup url: "http://localhost:3000" do |c|
  # Request
  c.use Faraday::Request::UrlEncoded

  # Response
  c.use Her::Middleware::DefaultParseJSON

  # Adapter
  c.use Faraday::Adapter::NetHttp
end

Dir[Rails.root.join("prereq/models/**/*.rb")].each {|f| require f}
FactoryGirl.definition_file_paths = ['./prereq/factories']
FactoryGirl.find_definitions