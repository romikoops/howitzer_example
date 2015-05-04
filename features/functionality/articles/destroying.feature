Feature: Article Destroying
  As a admin user
  I want to delete my article
  So other users can't see my article

  Background:
    Given logged in as admin user
    And there is article with parameters:
      | title     | UNIQ_ARTICLE[:title]  |
      | text      | UNIQ_ARTICLE[:text]   |
    And I open articles list page

  Scenario: user can remove article with confirmation action
    When I destroy UNIQ_ARTICLE[:title] article on articles list page
    And I confirm destroy action
    Then I should not see UNIQ_ARTICLE[:title] article on articles list page:

  Scenario: user can not remove article without confirmation action
    When I destroy UNIQ_ARTICLE[:title] article on articles list page
    And I don't confirm destroy action
    Then I should see UNIQ_ARTICLE[:title] article on articles list page: