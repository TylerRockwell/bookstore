Feature: Purchasing a Book
  Scenario: Happy Path
    Given I am logged into the site
      And there are some books in the database
    When I visit the public book index
      And I click on a book
      And I click "Add to Cart"
    Then the book is added to my cart
    When I visit my cart
    Then I see the book in my cart

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
