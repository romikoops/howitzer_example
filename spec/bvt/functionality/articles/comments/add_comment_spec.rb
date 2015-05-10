require 'spec_helper'

feature "Adding Comment" do
  background "Create article, user, comment" do
    @article = Gen.article
    @comment = Gen.comment
    @user1 = Gen.user

    log_in_as_admin
    create_article(@article)
    sign_up_as(@user1)
    log_in_as(@user1)
    article_open(@article)
  end

  scenario "User can add comment with valid comment body" do
    ArticlePage.given.fill_form(body: @comment.text)
    ArticlePage.given.submit_form
    expect(ArticlePage.given.text).to include("Comment was successfully added to current article.")
  end

  scenario "User can not add comment with blank comment body" do
    ArticlePage.given.fill_form(body: nil)
    ArticlePage.given.submit_form
    expect(ArticlePage.given.text).to include("Body can't be blank")
  end
end