@wip
Feature: Article Destroying
  As a user
  I want to delete my article
  So other users can't see my article

  Background:
    Given registered user with data:
      | user_name | UNIQ_USER[:full_name] |
      | email     | UNIQ_USER[:email]     |
      | password  | UNIQ_USER[:password]  |
    And article with parameters:
      | title     | UNIQ_ARTICLE[:title]  |
      | text      | UNIQ_ARTICLE[:text]   |
    And opened articles list page

  Scenario: user can remove article with confirmation action
    When I click Destroy button on article UNIQ_ARTICLE[:title] on articles list page
    And I confirm action
    Then I should not see article on articles list page with parameters:
      | title     | UNIQ_ARTICLE[:title]  |
      | text      | UNIQ_ARTICLE[:text]   |

  Scenario: user can not remove article without confirmation action
    When I click Destroy button on article UNIQ_ARTICLE[:title] on articles list page
    And I don't confirm action
    Then I should see article on articles list page with parameters:
      | title     | UNIQ_ARTICLE[:title]  |
      | text      | UNIQ_ARTICLE[:text]   |