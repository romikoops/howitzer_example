class ArticlesListPage < WebPage
  URL = '/articles/'
  validates :title, pattern: /\ADemo web application - Listing Articles\z/

  add_locator :new_article_button, xpath: "//a[@href='/articles/new']"
  add_locator :destroy_button, ->(title) { {xpath: "//A[.='#{title}']/following::a[@class='btn btn-default btn-xs btn-danger'][position()=1]"} }

  def add_new_article
    log.info "Adding new article"
    find(locator(:new_article_button)).click
    NewArticlePage.given
  end


  def destroy_article(title)
    find(apply(locator(:destroy_button), title)).click
  end

end
