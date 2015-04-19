require_relative 'main_menu'

class UsersPage < WebPage
  URL = '/users'
  validates :title, pattern: /\ADemo web application - Users\z/

  include MainMenu

end