@ok
Feature: Password Resetting
  As a user
  I want to reset my password
  So I can login the system with new password

  @bvt
  Scenario: user can reset password with correct data
    Given registered user with data:
      | user_name            | UNIQ_USER[:full_name] |
      | email                | UNIQ_USER[:email]     |
      | password             | UNIQ_USER[:password]  |
    And Login page of web application
    When I click 'Forgot password' link on Login page
    And I fill 'Forgot password' form on Forgot password page with data:
      | email                | UNIQ_USER[:email]     |
    And I submit 'Forgot password' form on Forgot password page
    Then I should see following text on Login page:
      """
      You will receive an email with instructions on how to reset your password in a few minutes.
      """
    And I should receive reset password confirmation email for UNIQ_USER[:email] recipient
    When I confirm UNIQ_USER[:email] resetting password from confirmation email
    And I fill 'Change password' form on Change password page with data:
      | new password         | UNIQ_USER1[:password] |
      | confirm new password | UNIQ_USER1[:password] |
    And I submit 'Change password' form on Change password page
    Then I should be logged in the system
    And I should see following text on Home page:
      """
      Your password was changed successfully. You are now signed in.
      """
      
  @p1
  Scenario: user can not reset password with incorrect new password
    Given registered user with data:
      | user_name            | UNIQ_USER[:full_name] |
      | email                | UNIQ_USER[:email]     |
      | password             | UNIQ_USER[:password]  |
    And Login page of web application
    When I click 'Forgot password' link on Login page
    And I fill 'Forgot password' form on Forgot password page with data:
      | email                | UNIQ_USER[:email]     |
    And I submit 'Forgot password' form on Forgot password page
    Then I should see following text on Login page:
      """
      You will receive an email with instructions on how to reset your password in a few minutes.
      """
    And I should receive reset password confirmation email for UNIQ_USER[:email] recipient
    When I confirm UNIQ_USER[:email] resetting password from confirmation email
    And I fill 'Change password' form on Change password page with data:
      | new password         | 1234567890 |
      | confirm new password | 1234567    |
    And I submit 'Change password' form on Change password page
    Then I should see following text on Change password page:
      """
      1 error prohibited this user from being saved:
      Password confirmation doesn't match Password
      """
    When I fill 'Change password' form on Change password page with data:
      | new password         | 1234567    |
      | confirm new password | 1234567    |
    And I submit 'Change password' form on Change password page
    Then I should see following text on Change password page:
      """
      1 error prohibited this user from being saved:
      Password is too short (minimum is 8 characters)
      """
      
  @p1
  Scenario: user can not reset password with incorrect email
    Given registered user with data:
      | user_name | UNIQ_USER[:full_name]  |
      | email     | UNIQ_USER[:email]      |
      | password  | UNIQ_USER[:password]   |
    And Login page of web application
    When I click 'Forgot password' link on Login page
    And I fill 'Forgot password' form on Forgot password page with data:
      | email     | test@resetpassword.com |
    And I submit 'Forgot password' form on Forgot password page
    Then I should see following text on Forgot password page:
      """
      1 error prohibited this user from being saved:
      Email not found
      """
    When I fill 'Forgot password' form on Forgot password page with data:
      | email     | test.1234567890        |
    And I submit 'Forgot password' form on Forgot password page
    Then I should see following text on Forgot password page:
      """
      Email format data must contain symbol @
      """
      
  @p1
  Scenario: user can login with old password until confirmation email for new password is not confirmed
    Given registered user with data:
      | user_name | UNIQ_USER[:full_name] |
      | email     | UNIQ_USER[:email]     |
      | password  | UNIQ_USER[:password]  |
    And Login page of web application
    When I click 'Forgot password' link on Login page
    And I fill 'Forgot password' form on Forgot password page with data:
      | email     | UNIQ_USER[:email]     |
    And I submit 'Forgot password' form on Forgot password page
    Then I should see following text on Login page:
      """
      You will receive an email with instructions on how to reset your password in a few minutes.
      """
    When I fill Login form on Login page with data:
      | email     | UNIQ_USER[:email]     |
      | password  | UNIQ_USER[:password]  |
    And I submit Login form on Login page
    Then I should be logged in the system
    And I should be redirected to Home page
