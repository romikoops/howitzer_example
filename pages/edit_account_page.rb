require_relative 'main_menu'

class EditAccountPage < WebPage
    URL = '/users/edit'
    validates :url, pattern: /\/users\/edit\/?\z/

  add_button_locator :cancel_account_button, 'Cancel my account'
  add_button_locator :update_account_btn, 'update'
  add_field_locator :name, 'user_name'
  add_field_locator :user_email, 'user_email'
  add_field_locator :user_password, 'user_password'
  add_field_locator :current_password, 'user_current_password'

   include MainMenu

    def cancel_my_account
      log.info "Cancelling user account"
      click_button(button_locator :cancel_account_button)
    end
  end
