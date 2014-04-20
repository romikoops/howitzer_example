@ok @bvt
Feature: Blank page

  Scenario: Testing General Blank Page
    Given opened browser
    Then blank page should be displayed
    When I open home page
    Then home page should be displayed
    And I open blank page
    Then blank page should be displayed
