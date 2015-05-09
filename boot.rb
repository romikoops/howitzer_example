Dir.chdir(File.join(File.dirname(__FILE__), '.'))

def settings
  SexySettings::Base.instance()
end

require 'active_support/all' #TODO remove after upgrading to next version of Howitzer
require 'howitzer'
Capybara.asset_host = app_url

Dir[File.join(File.dirname(__FILE__), "./emails/**/*.rb")].each {|f| require f}
Dir[File.join(File.dirname(__FILE__), "./pages/**/*.rb")].each {|f| require f}
