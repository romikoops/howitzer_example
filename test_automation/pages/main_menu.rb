module MainMenu
  def self.included(base)
    base.class_eval do
      add_locator   :menu_item,  lambda{|name| {xpath: ".//*[@id='main_menu']//li[.='#{name}']"} }

      def self.authenticated?
        !first(locator(:menu_item).('Logout')).nil?
      end
    end
  end

  def choose_menu(text)
    log.info "Open '#{text}' menu"
    find(locator(:menu_item).(text)).click
  end
end