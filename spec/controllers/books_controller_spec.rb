require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:user) { create(:user) }
  let!(:confirm_user) { user.confirm }
  let!(:sign_in_user) { sign_in user }
  let(:book) { create(:book) }
  let(:book_list) { create_list(:book, 25) }
  describe "GET #index" do
    let!(:send_request) { get :index }
    let(:sort_params) { { sort_field: "title", sort_order: "ASC" } }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    context "when no params are sent" do
      it "assigns all books to @books" do
        expect(assigns(:books)).to eq(book_list)
      end

      let(:old_book) { create(:book, published_date: Date.today - 50.years) }
      let(:new_book) { create(:book, published_date: Date.today) }
      it "sorts books by published_date" do
        expect(assigns(:books)).to eq([new_book, old_book])
      end
    end

    context "when a user searches" do
      let!(:send_request) { get :index, search_params }
      let(:search_params) { { search: "This Unique Book" } }
      let!(:book_list) { create_list(:book, 25) }
      let!(:matching_book) { create(:book, title: "This Unique Book") }

      it "should assign only matching books" do
        expect(assigns(:books).count).to be 1
      end
    end
  end
end
