require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:published_date) }
    it { is_expected.to validate_presence_of(:author) }
    it { is_expected.to validate_presence_of(:price) }
  end

  describe ".most_popular" do
    let!(:book_a) { create(:book, title: "0 SALES Almost There: When to Give Up on Your Dreams") }
    let!(:book_c) { create(:book, title: "5 SALES Gambling: Betting the house on the horse") }
    let!(:book_b) { create(:book, title: "3 SALES Breaking Even: A Practical Guide") }
    let!(:book_d) { create(:book, title: "4 SALES Because why not") }
    let!(:book_c_orders) { create(:order_item, book: book_c, quantity: 5) }
    let!(:book_b_orders) { create(:order_item, book: book_b, quantity: 2) }
    let!(:book_b_orders2) { create(:order_item, book: book_b, quantity: 1) }
    let!(:book_d_orders) { create(:order_item, book: book_d, quantity: 6) }

    it "returns all books ordered by number of sales" do
      expect(Book.most_popular).to eq([book_d, book_c, book_b, book_a])
    end
  end

  describe "#order_by(field)" do
    context "when parameter is title" do
      let!(:book_b) { create(:book, title: "Breaking Even: A Practical Guide") }
      let!(:book_a) { create(:book, title: "Almost There: When to Give Up on Your Dreams") }

      it "returns all books sorted by title" do
        expect(Book.order_by("title", "ASC")).to eq([book_a, book_b])
      end
    end

    context "when parameter is price" do
      let!(:expensive_book) { create(:book, price: 199.99) }
      let!(:cheap_book) { create(:book, price: 4) }
      let!(:middle_book) { create(:book, price: 34.99) }

      it "returns all books sorted by price" do
        expect(Book.order_by("price", "ASC")).to eq([cheap_book, middle_book, expensive_book])
      end
    end
  end

  describe ".searchable_fields" do
    it "returns a list of all fields that can be used for sorting" do
      expect(Book.searchable_fields).to eq(
        [:title, :author, :category]
      )
    end
  end

  describe ".search" do
    let(:matching_book) do
      create(
        :book,
        title: "Cutting Corners: Using Your Business to Line Your Pockets",
        published_date: Date.today,
        author: "Roger Miyosaki",
        category: "Non-fiction"
      )
    end

    let(:irrelevant_book) do
      create(
        :book,
        title:          "Accounting? Who needs it?",
        published_date: Date.today - 5.years,
        author:         "Grant Parker",
        category:       "Finance"
      )
    end

    it "searches books on all user-facing fields" do
      expect(Book.search("Corners")).to include(matching_book)
      expect(Book.search("Corners")).to_not include(irrelevant_book)

      expect(Book.search("Roger")).to include(matching_book)
      expect(Book.search("Roger")).to_not include(irrelevant_book)

      expect(Book.search("Non-fiction")).to include(matching_book)
      expect(Book.search("Non-fiction")).to_not include(irrelevant_book)
    end
  end
end
