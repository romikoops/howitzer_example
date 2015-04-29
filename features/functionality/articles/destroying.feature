Feature: Article Destroying
  As a admin user
  I want to delete my article
  So other users can't see my article

  Background:
    Given logged in as admin user with data:
      | email     | admin@strongqa.com     |
      | password  | 1234567890             |
    And article with parameters:
      | title     | UNIQ_ARTICLE[:title]  |
      | text      | UNIQ_ARTICLE[:text]   |
    And I open articles list page

  Scenario: user can remove article with confirmation action
    When I click Destroy button on article UNIQ_ARTICLE[:title] on articles list page
    And I confirm action
    Then I should not see article on articles list page with data:
      | title     | UNIQ_ARTICLE[:title]  |
      | text      | UNIQ_ARTICLE[:text]   |

  Scenario: user can not remove article without confirmation action
    When I click Destroy button on article UNIQ_ARTICLE[:title] on articles list page
    And I don't confirm action
    Then I should see article on articles list page with data:
      | title     | UNIQ_ARTICLE[:title]  |
      | text      | UNIQ_ARTICLE[:text]   |