Feature: Bookstore Administration Panel
  Scenario: Admin Authentication
    Given I have an admin account
    When I visit the admin panel url
      And I enter my admin email
      And I enter my admin password
      And I click "Log in"
    Then I see the admin panel

  Scenario: Invalid Login
    Given I do not have an admin account
    When I visit the admin panel url
      And I enter my admin email
      And I enter my admin password
      And I click "Log in"
    Then I see a flash notification that says "Invalid email or password"

  Scenario: Adding a new admin
    Given I am logged into the admin panel
      And I click "Create a new admin"
      And I enter the email "new_admin@example.com"
      And I enter a password with correct confirmation
      And I click "Submit"
    Then I see a flash notification that says "Admin created"

  Scenario: Adding a book
    Given I am logged into the admin panel
      And I am logged into the site
    When I visit the admin books url
      And I click "Add a Book"
      And I enter the title "Test Book"
      And I enter the price "135.99"
      And I enter the published date "2015-08-10"
      And I enter the author "Some Person"
      And I click "Submit"
      And I visit the admin books url
    Then I see the book "Test Book"
    When I visit the public book index
    Then I see the book "Test Book"
      And I see the book published date "August 10, 2015"
      And I see the book author "Some Person"

  @javascript
  Scenario: Deleting a book
    Given I am logged into the admin panel
      And I am logged into the site
      And there is a book named "Book To Be Deleted"
    When I visit the admin books url
      And I click "Delete" for the book "Book To Be Deleted"
    Then I see a prompt requesting that I confirm my decision to delete the book
    When I confirm my decision to delete the book
    Then I don't see "Book To Be Deleted"
    When I visit the public book index
    Then I don't see "Book To Be Deleted"


  Scenario: Editing a book
    Given I am logged into the admin panel
      And I am logged into the site
      And there is a book named "Book To Be Edited" valued at "135.99"
    When I visit the admin books url
      And I click "Edit" for the book "Book To Be Edited"
      And I change the book name to "Book That Has Been Edited"
      And I change the book price to "222.22"
      And I click "Submit"
      And I visit the admin books url
    Then I see the book "Book That Has Been Edited"
    When I visit the public book index
    Then I see the book "Book That Has Been Edited"

  Scenario: Viewing a list of orders
    Given I am logged into the admin panel
      And There are orders
    When I visit the admin order index
    Then I see a list of orders placed on the site

  Scenario: Discounting a book in dollars
    Given I am logged into the admin panel
      And I am logged into the site
      And there is a book named "Book To Be Discounted" valued at "100.00"
    When I visit the admin books url
      And I click "Edit" for the book "Book To Be Discounted"
      And I apply a discount of 10 "dollars"
      And I click "Submit"
      And I visit the admin books url
    Then I see the book with a price of "$90.00" dollars

  Scenario: Discounting a book by a percentage
    Given I am logged into the admin panel
      And I am logged into the site
      And there is a book named "Book To Be Discounted" valued at "200.00"
    When I visit the admin books url
      And I click "Edit" for the book "Book To Be Discounted"
      And I apply a discount of 20 "percent"
      And I click "Submit"
      And I visit the admin books url
    Then I see the book with a price of "$160.00" dollars

  Scenario: Removing a discount from a book
    Given I am logged into the admin panel
      And I am logged into the site
      And there is a book named "Discounted book" valued at "200.00"
      And the book has a discount of 20 dollars
    When I visit the admin books url
      And I click "Edit" for the book "Discounted book"
      And I leave the discount fields blank
      And I click "Submit"
      And I visit the admin books url
    Then I see the book with a price of "$200.00" dollars
