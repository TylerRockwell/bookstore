Feature: Order
  @javascript
  Scenario: User places a new order
    Given I am logged into the site
      And there are some books in the database
    When I visit the public book index
      And I click on a book
      And I click "Add to Cart"
      And I visit my cart
      And I click "Purchase"
      And I click "Pay with Card"
      And I enter my payment details
    Then I see "Your order has been placed"
