Feature: User Authentication
  Scenario: User successfully authenticates
    Given I have an account on the site
    And My account is confirmed
    When I visit the site root path
    Then I am presented with a login page
    When I enter my correct email
    And I enter my password
    And I click submit
    Then I am redirected to the book index page

  Scenario: User enters invalid authentication information
    Given I have an account on the site
    And My account is confirmed
    When I visit the site root path
    Then I am presented with a login page
    When I enter the wrong password
    And I click submit
    Then I am notified that my password is incorrect
