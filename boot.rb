Dir.chdir(File.join(File.dirname(__FILE__), '.'))

def settings
  SexySettings::Base.instance
end

require 'active_support/all' #TODO remove after upgrading to next version of Howitzer
require 'howitzer'
require_relative 'prereq'
Capybara.asset_host = 'http://demoapp.strongqa.com'

Dir[File.join(File.dirname(__FILE__), "./emails/**/*.rb")].each {|f| require f}
Dir[File.join(File.dirname(__FILE__), "./pages/**/*.rb")].each {|f| require f}
