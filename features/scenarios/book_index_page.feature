Feature: Book index store page
  Scenario: Book pagination
    Given there are 100 books in the database
      And I am logged into the site
    When I visit the root url
    Then I see a list of books in the database
      And the books are ordered by published date
      And the list of books is paginated 25 books per page

  Scenario: Book Sorting
    Given there are 100 books in the database
      And some books have been ordered
      And I am logged into the site
    When I visit the root url
      And I sort by "Most popular"
    Then the books are re-sorted based on the amount of times they are purchased

  Scenario: Book searching
    Given there are 100 books in the database
      And I am logged into the site
    When I visit the root url
      And I enter a book's title into the book search field
    Then I am shown a list of books with that title
