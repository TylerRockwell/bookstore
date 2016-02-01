Feature: Bookstore Administration Panel
  Scenario: Admin Authentication
    Given I have an admin account
    When I visit the admin panel url
      And I enter my admin email
      And I enter my admin password
      And I click submit
    Then I see the admin panel
