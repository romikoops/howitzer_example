module MainMenu
  def self.included(base)
    base.class_eval do
      add_locator   :menu, '#main_menu'
      add_locator   :menu_item,  lambda{|name| {xpath: ".//*[@id='main_menu']//li[.='#{name}']/a"} }
      add_locator :menu_small, '.navbar-toggle'

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
end