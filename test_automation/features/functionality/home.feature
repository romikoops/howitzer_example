Feature: Home

  Scenario: visitor can see Home page of web application
    Given registered user with parameters:
      | user_name | UNIQ_USER[:full_name] |
      | email     | UNIQ_USER[:email]     |
      | password  | UNIQ_USER[:password]  |
    And article created by UNIQ_USER[:email] user with parameters:
      | title     | UNIQ_ARTICLE[:title]   |
      | text      | UNIQ_ARTICLE[:text]    |
    And Home page of web application
    Then I should see UNIQ_ARTICLE[:creation_date] form on Home page with data:
      | article_data | UNIQ_ARTICLE[:creation_time] UNIQ_ARTICLE[:title] |