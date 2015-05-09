require 'spec_helper'

feature "Article destroying" do

  before(:each) do
    log_in_as_admin
    ArticleListPage.open.add_new_article
    article=Gen::given_article_by_number(0)
    NewArticlePage.given.fill_form(title: article.title, text: article.text)
        .submit_form
    ArticleListPage.open
  end

  scenario "User can remove article with confirmation action" do
    title=Gen::given_article_by_number(0).title
    ArticleListPage.given.destroy_article(title)
    WebPage.accept_js_alert
    expect(ArticlesListPage.given.text).to_not include(title)
  end

  scenario "User can not remove article without confirmation action" do
    title=Gen::given_article_by_number(0).title
    ArticleListPage.given.destroy_article(title)
    WebPage.dismiss_js_alert
    expect(ArticlesListPage.given.text).to include(title)
  end

end