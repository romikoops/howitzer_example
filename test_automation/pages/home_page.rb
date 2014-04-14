require_relative 'main_menu'

class HomePage < WebPage
  URL = '/'
  validates :title, pattern: /\ADemo web application - Home\z/
  validates :url, pattern: /\A(?:.*?:\/\/)?[^\/]*\/?\z/

  include MainMenu
end