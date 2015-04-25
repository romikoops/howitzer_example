require_relative 'main_menu'

class UsersPage < WebPage
  URL = '/users'
  validates :title, pattern: /\ADemo web application - Users\z/

  include MainMenu

  def open_user(user_email)
    click_link_or_button user_email
  end

end