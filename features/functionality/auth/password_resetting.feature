@ok
Feature: Password Resetting
  As a user
  I want to reset my password
  So I can login the system with new password

  @bvt
  Scenario: user can reset password with correct data
    Given there is registered UNIQ_USER user
    And login page of web application
    When I click Forgot password? link on login page
    And I fill form on forgot password page with data:
      | email                | UNIQ_USER[:email]     |
    And I submit form on forgot password page
    Then I should see following text on login page:
      """
      You will receive an email with instructions on how to reset your password in a few minutes.
      """
    And I should receive reset password confirmation email for UNIQ_USER[:email] recipient
    When I confirm UNIQ_USER[:email] resetting password from reset password confirmation email
    And I fill form on change password page with data:
      | new_password         | UNIQ_USER1[:password] |
      | confirm_new_password | UNIQ_USER1[:password] |
    And I submit form on change password page
    Then I should be logged in the system
    And I should see following text on home page:
      """
      Your password was changed successfully. You are now signed in.
      """

  @p1
  Scenario: user can not reset password with incorrect new password
    Given there is registered UNIQ_USER user
    And login page of web application
    When I click Forgot password? link on login page
    And I fill form on forgot password page with data:

      | email                | UNIQ_USER[:email]     |
    And I submit form on forgot password page
    Then I should see following text on login page:
      """
      You will receive an email with instructions on how to reset your password in a few minutes.
      """
    And I should receive reset password confirmation email for UNIQ_USER[:email] recipient
    When I confirm UNIQ_USER[:email] resetting password from reset password confirmation email
    And I fill form on change password page with data:
      | new_password         | 1234567890 |
      | confirm_new_password | 1234567    |
    And I submit form on change password page
    Then I should see following text on change password page:
      """
      Password confirmation doesn't match Password
      """
    And I fill form on change password page with data:
      | new_password         | 1234567    |
      | confirm_new_password | 1234567    |
    And I submit form on change password page
    Then I should see following text on change password page:
      """
      Password is too short (minimum is 8 characters)
      """

  @p1
  Scenario: user can not reset password with incorrect email
    Given login page of web application
    When I click Forgot password? link on login page
    And I fill form on forgot password page with data:
      | email     | test@resetpassword.com |
    And I submit form on forgot password page
    Then I should see following text on forgot password page:
      """
      Email not found
      """
    And I fill form on forgot password page with data:
      | email     | test.1234567890        |
    And I submit form on forgot password page
    Then forgot password page should be displayed

  @p1
  Scenario: user can login with old password until confirmation email for new password is not confirmed
    Given there is registered UNIQ_USER user
    And login page of web application
    When I click Forgot password? link on login page
    And I fill form on forgot password page with data:
      | email     | UNIQ_USER[:email]     |
    And I submit form on forgot password page
    Then I should see following text on login page:
      """
      You will receive an email with instructions on how to reset your password in a few minutes.
      """
    When I fill form on login page with data:
      | email     | UNIQ_USER[:email]     |
      | password  | UNIQ_USER[:password]  |
    And I submit form on login page
    Then I should be logged in the system
    And I should be redirected to home page
