require 'factory_girl/step_definitions'
Dir[Rails.root.join("prereq/models/**/*.rb")].each {|f| require f}
FactoryGirl.definition_file_paths = ['./prereq/factories']
FactoryGirl.find_definitions