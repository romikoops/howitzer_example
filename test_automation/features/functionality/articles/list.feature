Feature: Articles list
  As user
  I want to view my articles
  So I can view my articles in Articles list

  Background:
    Given registered user with parameters:
      | user_name | UNIQ_USER[:full_name] |
      | email     | UNIQ_USER[:email]     |
      | password  | UNIQ_USER[:password]  |
    And article with parameters:
      | title     | UNIQ_ARTICLE1[:title] |
      | text      | UNIQ_ARTICLE1[:text]  |
    And article with parameters:
      | title     | UNIQ_ARTICLE2[:title] |
      | text      | UNIQ_ARTICLE2[:text]  |

  Scenario: user can see articles in Articles list
    When I go to the Articles list page
    Then I should see UNIQ_ARTICLE1[:title] article on Articles list page with data:
      | title     | UNIQ_ARTICLE1[:title] |
      | text      | UNIQ_ARTICLE1[:text]  |
    And I should see UNIQ_ARTICLE2[:title] article on Articles list page with data:
      | title     | UNIQ_ARTICLE2[:title] |
      | text      | UNIQ_ARTICLE2[:text]  |