@wip
Feature: Home

  Scenario: visitor can see home page of web application
    Given there is registered UNIQ_USER user
    And article created by UNIQ_USER[:email] user with parameters:
      | title     | UNIQ_ARTICLE[:title]   |
      | text      | UNIQ_ARTICLE[:text]    |
    And home page of web application
    Then I should see UNIQ_ARTICLE[:creation_date] form on home page with data:
      | article_data | UNIQ_ARTICLE[:creation_time] UNIQ_ARTICLE[:title] |