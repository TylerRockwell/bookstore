require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:published_date) }
    it { is_expected.to validate_presence_of(:author) }
    it { is_expected.to validate_presence_of(:price) }
  end

  describe "#order_by(field)" do
    context "when parameter is title" do
      let!(:book_b){ create(:book, title: "Breaking Even: A Practical Guide") }
      let!(:book_a){ create(:book, title: "Almost There: When to Give Up on Your Dreams") }

      it "returns all books sorted by title" do
        expect(Book.order_by("title", "ASC")).to eq([book_a, book_b])
      end
    end

    context "when parameter is price" do
      let!(:expensive_book){ create(:book, price: 199.99) }
      let!(:cheap_book){ create(:book, price: 4) }
      let!(:middle_book){ create(:book, price: 34.99) }

      it "returns all books sorted by price" do
        expect(Book.order_by("price", "ASC")).to eq([cheap_book, middle_book, expensive_book])
      end
    end
  end

  describe "#sortable_fields" do
    let(:book){ create(:book) }
    it "returns a list of all fields that can be used for sorting" do
      expect(book.sortable_fields).to eq(
        [:title, :published_date, :author, :price, :category]
      )
    end
  end

  describe "#search" do
    let(:matching_book){ create(:book,
      title: "Cutting Corners: Using Your Business to Line Your Pockets",
      published_date: Date.today,
      author: "Roger Miyosaki",
      category: "Non-fiction"
      )
    }
    let(:irrelevant_book){ create(:book,
      title: "Accounting? Who needs it?",
      published_date: Date.today - 5.years,
      author: "Grant Parker",
      category: "Finance"
      )
    }

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
end
