require_relative 'main_menu'

class HomePage < WebPage
  URL = '/'
  validates :url, pattern: /\A(?:.*?:\/\/)?[^\/]*\/?\z/

  include MainMenu
end