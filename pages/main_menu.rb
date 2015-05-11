module MainMenu
  def self.included(base)
    base.class_eval do
      add_locator   :menu, '#main_menu'
      add_locator   :menu_item,  lambda{|name| {xpath: ".//*[@id='main_menu']//a[.='#{name}']"} }
      add_locator :menu_small, '.navbar-toggle'
      add_locator :error_message, css: '#error_explanation'
      add_locator :flash_message, css: '#flash_notice'

      def self.authenticated?
        if phantomjs_driver?
          find(locator(:menu_small)).click
        end

        find(locator :menu)
        !first(locator(:menu_item).('Logout')).nil?
      end
    end
  end

  def choose_menu(text)
    log.info "Open '#{text}' menu"
    if phantomjs_driver?
      find(locator(:menu_small)).click
      click_link("#{text}",match: :first)
    else
      find(locator(:menu_item).(text)).click
    end
  end

  def flash_message
    find(locator(:flash_message)).text
  end

  def error_message
    find(locator(:error_message)).text
  end
end