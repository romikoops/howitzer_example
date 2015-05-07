class WebPage

  def self.accept_js_alert
    accept_alert
  end

  def self.dismiss_js_alert
    page.driver.browser.switch_to.alert.dismiss
  end

end