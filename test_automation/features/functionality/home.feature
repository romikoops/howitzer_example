Feature: Home

  Scenario: visitor can see Home page of web application
    Given created article with parameters:
      | title     | UNIQ_ARTICLE[:title] |
      | text      | UNIQ_ARTICLE[:text]  |
    And Home page of web application
    Then I should see UNIQ_ARTICLE[:creation_date] form on Home page with data:
      | article_data | UNIQ_ARTICLE[:creation_time] UNIQ_ARTICLE[:title] |