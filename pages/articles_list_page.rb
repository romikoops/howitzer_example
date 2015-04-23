class ArticlesListPage < WebPage
  URL = '/articles/'
  validates :title, pattern: /\ADemo web application - Listing Articles\z/

  add_locator :new_article_button,  xpath: "//a[@href='/articles/new']"

  def add_new_article
    log.info "Adding new article"
    find(locator(:new_article_button)).click
    NewArticlePage.given
  end

end