require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:order_items) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:published_date) }
    it { is_expected.to validate_presence_of(:author) }
    it { is_expected.to validate_presence_of(:price) }
  end

  describe ".order_by(field)" do
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

  describe ".sort_options" do
    it "returns a list of all fields that can be used for sorting" do
      expect(Book.sort_options).to eq(
        [
          ["Title", "title"],
          ["Published date", "published_date"],
          ["Author", "author"], ["Price", "price"],
          ["Category", "category"],
          ["Most popular"]
        ]
      )
    end
  end

  describe ".searchable_fields" do
    it "returns a list of all fields that can be used for searching" do
      expect(Book.searchable_fields).to eq(
        [:title, :published_date, :author, :price, :category]
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

      expect(Book.search(Date.today.year)).to include(matching_book)
      expect(Book.search(Date.today.year)).to_not include(irrelevant_book)

      expect(Book.search("Roger")).to include(matching_book)
      expect(Book.search("Roger")).to_not include(irrelevant_book)

      expect(Book.search("Non-fiction")).to include(matching_book)
      expect(Book.search("Non-fiction")).to_not include(irrelevant_book)
    end
  end

  describe "#times_sold" do
    let(:book) { create(:book) }
    context "when there are no sales" do
      it "returns 0" do
        expect(book.times_sold).to eq(0)
      end
    end

    context "when there is 1 sale" do
      let!(:sale) { create(:order_item, book: book, quantity: 1) }
      it "returns 1" do
        expect(book.times_sold).to eq(1)
      end
    end

    context "when there are multiple sales" do
      let!(:sale1) { create(:order_item, book: book, quantity: 4) }
      let!(:sale2) { create(:order_item, book: book, quantity: 5) }
      it "returns the sum of all the sales" do
        expect(book.times_sold).to eq(9)
      end
    end
  end
end
