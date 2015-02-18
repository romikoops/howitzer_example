Feature: Visitor Permissions
  As a visitor
  I want to view pages of the system
  So I can see what pages are available to the visitor

  Background:
    Given created article with parameters:
      | title     | UNIQ_ARTICLE[:title] |
      | text      | UNIQ_ARTICLE[:text]  |
    And opened Home page of web application

  Scenario: visitor is viewing pages of the system
    When I click Login menu item
    Then I should be redirected to Login page
    When I click 'Sign up' menu item 
    Then I should be redirected to Sign up page
    When I click Home menu item 
    Then I should be redirected to Home page
    When I click Articles menu item
    Then I should be redirected to Articles list page
    When I click on UNIQ_ARTICLE[:title] article on Articles list page
    Then I should be redirected to UNIQ_ARTICLE[:title] article page