Feature: Purchasing a Book
  @javascript
  Scenario: Happy Path
    Given I am logged into the site
      And there are some books in the database
    When I visit the public book index
      And I click on a book
      And I click "Add to Cart"
    Then the book is added to my cart
    When I visit my cart
    Then I see the book in my cart
    When I click "Purchase"
      And I enter a valid shipping address
      And I enter a valid billing address
      And I click "Next"
    Then I am asked to review the order total
    When I click "Pay with Card"
      And I enter a valid credit card
    Then I am shown the order summary

  Scenario: Quantity adjustment
    Given I am logged into the site
      And there are some books in the database
    When I visit the public book index
      And I click on a book
      And I enter 2 for the quantity
      And I click "Add to Cart"
    Then the book is added to my cart with quantity 2
    When I visit my cart
    Then I see the book in my cart with quantity 2
    When I adjust the quantity of the book to 3
    Then I see the book in my cart with quantity 3
