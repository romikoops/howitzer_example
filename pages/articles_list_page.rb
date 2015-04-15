class ArticlesListPage < WebPage
  URL = '/articles/'
  validates :title, pattern: /\ADemo web application - Listing Articles\z/
  validates :url, pattern: /\/articles/


  add_locator :new_article_button,  xpath: "//a[@href='/articles/new']"


  def add_new_article
    log.info "Adding new article"
   # find(:xpath, "/html/body/main/a[1]").click
    find(locator(:new_article_button)).click
   # click_button(button_locator :new_article_button)
    NewArticlePage.given
  end


end