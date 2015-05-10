class ArticleListPage < WebPage
  URL = '/articles/'
  validates :title, pattern: /\ADemo web application - Listing Articles\z/

  add_locator :new_article_button,  xpath: "//a[@href='/articles/new']"
  add_locator :article_button, lambda{|title| {xpath: "//a[contains(.,'#{title}')]"} }
  add_locator :destroy_button, ->(title) { {xpath: "//strong[.='#{title}']/following-sibling::a[normalize-space(.)='Destroy'][1]"} }

  def add_new_article
    log.info "Adding new article"
    find(locator(:new_article_button)).click
    NewArticlePage.given
  end

  def destroy_article(title)
    find(apply(locator(:destroy_button), title)).click
  end

  def click_article_button(text)
    log.info "Open '#{text}' article"
    if phantomjs_driver?
      click_link("#{text}",match: :first)
    else
      find(apply(locator(:article_button),(text))).click
    end
  end
end