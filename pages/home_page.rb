require_relative 'main_menu'

class HomePage < WebPage
  URL = '/'
  validates :title, pattern: /\ADemo web application - Home\z/
  validates :url, pattern: /\A(?:.*?:\/\/)?[^\/]*\/?\z/

  add_locator :article_link, lambda{|title| {xpath: ".//a[.='#{title}']"}}

  include MainMenu

  def view_article(article_title)
    log.info "Open article page byb title: '#{article_title}'"
    find(apply(locator(:article_link), article_title)).click
    ArticlePage.given
  end
end