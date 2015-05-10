module CreateArticleHelper
  def create_article(article)
    NewArticlePage.open.fill_form(title: article.title, text: article.text)
        .submit_form
    expect(ArticlePage.given.text).to include(article.title)
    expect(ArticlePage.given.text).to include(article.text)
    ArticlePage.given.choose_menu('Logout')
  end

  def article_open(article)
    ArticleListPage.open.click_article_button(article.title)
    expect(ArticlePage).to be_authenticated
    ArticlePage.wait_for_opened
  end
end

RSpec.configure do |config|
  config.include CreateArticleHelper
end