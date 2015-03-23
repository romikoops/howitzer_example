module MainMenu
  def self.included(base)
    base.class_eval do
      add_locator   :menu, '#main_menu'
      add_locator   :menu_item,  lambda{|name| {xpath: ".//*[@id='main_menu']//li[.='#{name}']/a"} }

      def self.authenticated?
          find(locator :menu)
        !first(locator(:menu_item).('Logout')).nil?
      end
    end
  end

  def choose_menu(text)
    log.info "Open '#{text}' menu"

    find(locator(:menu_item).(text)).click
  end
end