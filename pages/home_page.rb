require_relative 'main_menu'

class HomePage < WebPage
  URL = '/'
  validates :title, pattern: /\ADemo web application - Home\z/
  validates :url, pattern: /\A(?:.*?:\/\/)?[^\/]*\/?\z/

  add_locator :article_link, lambda{|title| {xpath: ".//a[.='#{title}']"}}
  add_locator :message,        css: "#flash_notice"
  add_locator :log_oul_link,   css: "a[href='/users/sign_out']"

  include MainMenu

  def view_article(article_title)
    log.info "Open article page byb title: '#{article_title}'"
    find(apply(locator(:article_link), article_title)).click
    ArticlePage.given
  end

  def confirmation_text
    find(locator(:message))
  end
end