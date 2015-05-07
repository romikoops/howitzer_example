class ArticleListPage < WebPage
  URL = '/articles/'
  validates :title, pattern: /\ADemo web application - Listing Articles\z/

  add_locator :new_article_button,  xpath: "//a[@href='/articles/new']"
  add_locator :article_button, lambda{|title| {xpath: "///a[contains(.,'#{title}')]"} }

  def add_new_article
    log.info "Adding new article"
    find(locator(:new_article_button)).click
    NewArticlePage.given
  end

  def click_article_button(text)
    log.info "Open '#{text}' article"
    if phantomjs_driver?
      find(locator(:article_button)).click
      click_link("#{text}",match: :first)
    else
      find(apply(locator(:article_button),(text))).click
    end
  end

end