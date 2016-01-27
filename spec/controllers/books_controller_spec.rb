require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:book){ create(:book) }
  let(:book_list){ create_list(:book, 50) }
  let(:old_book){ create(:book, published_date: Date.today - 50.years)}
  let(:new_book){ create(:book, published_date: Date.today) }

  describe "GET #index" do

    let(:send_request){ get :index }
    let(:sort_params){ { sort_field: "title", sort_order: "ASC" } }

    it "returns http success" do
      send_request
      expect(response).to have_http_status(:success)
    end

    context "when no params are sent" do
      it "assigns all books to @books" do
        send_request
        expect(assigns(:books)).to eq(book_list)
      end

      it "sorts books by published_date" do
        send_request
        [old_book, new_book]
        expect(assigns(:books)).to eq([new_book, old_book])
      end
    end

    context "when a user searches" do
      let(:send_request){ get :index, search_params }
      let(:search_params){ { search: "This Unique Book" } }
      let!(:book_list){ create_list(:book, 50) }
      let!(:matching_book){ create(:book, title: "This Unique Book") }

      it "should assign only matching books" do
        send_request
        expect(assigns(:books).count).to be 1
      end
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  # describe "POST #create" do
  #   it "returns http success" do
  #     get :create
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  describe "GET #edit" do
    let(:params){ { id: book.id } }
    let(:send_request){ get :edit, params}
    it "returns http success" do
      send_request
      expect(response).to have_http_status(:success)
    end
  end

  # describe "PUT #update" do
  #   it "returns http success" do
  #     get :update
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "DELETE #destroy" do
  #   it "returns http success" do
  #     get :destroy
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
