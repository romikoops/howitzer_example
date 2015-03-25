Dir.chdir(File.join(File.dirname(__FILE__), '.'))

def settings
  SexySettings::Base.instance()
end

require 'active_support/all'
require 'howitzer'
Capybara.asset_host = 'http://localhost:3000'

Dir[File.join(File.dirname(__FILE__), "./emails/**/*.rb")].each {|f| require f}
Dir[File.join(File.dirname(__FILE__), "./pages/**/*.rb")].each {|f| require f}
