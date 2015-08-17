Feature: Article Destroying
  As an admin user
  I want to delete my article
  So other users can't see my article

  Background:
    Given I am logged in as admin user
    And there is article with parameters:
      | title     | UNIQ_ARTICLE[:title]  |
      | text      | UNIQ_ARTICLE[:text]   |
    And I am on article list page

  Scenario: user can remove article with confirmation action
    When I destroy UNIQ_ARTICLE[:title] article with confirmation on article list page
    Then I should not see UNIQ_ARTICLE[:title] article on article list page

  Scenario: user can not remove article without confirmation action
    When I destroy UNIQ_ARTICLE[:title] article without confirmation on article list page
    Then I should see UNIQ_ARTICLE[:title] article on article list page