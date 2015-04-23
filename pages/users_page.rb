require_relative 'main_menu'

class UsersPage < WebPage
  URL = '/users'
  validates :title, pattern: /\ADemo web application - Users\z/

  include MainMenu

  def click_user_link(user_email)
    find(apply(locator(:user_link), user_email)).click
    UserViewPage.given
  end

end