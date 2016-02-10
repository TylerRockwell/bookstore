Feature: Purchasing a Book
  @javascript
  Scenario: Happy Path
    Given I am logged into the site
      And there are some books in the database
    When I visit the public book index
      And I click on a book
      And I click "Add to Cart"
    Then I see the book in my cart
    When I click "Purchase"
      And I enter a valid shipping address
      And I enter a valid billing address
      And I enter a valid credit card
      And I click "Submit Order"
    Then I am asked to review the order total
    When I click "Confirm"
    Then I am shown the order summary
      And my credit card is saved for future purchases

  Scenario: Quantity adjustment
    Given I am logged into the site
      And there are some books in the database
    When I visit the public book index
      And I click on a book
      And I enter 2 for the quantity
      And I click "Add to Cart"
      And I visit my cart
    Then I see the book in my cart with quantity 2
    When I adjust the quantity of the book to 3
    Then I see the book in my cart with quantity 3

  Scenario: With a saved Credit Card
    Given I am logged into the site
      And there are some books in the database
      And I have a credit card saved on the site
    When I visit the public book index
      And I click on a book
      And I click "Add to Cart"
      And I visit my cart
    Then I see the book in my cart
    When I click "Purchase"
      And I enter a valid shipping address
      And I choose to use my saved credit card
      And I click "Submit Order"
    Then I am asked to review the order total
    When I click "Confirm"
    Then I am shown the order summary
      And my credit card is saved for future purchases
