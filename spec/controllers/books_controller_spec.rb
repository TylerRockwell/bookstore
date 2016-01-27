require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:book){ create(:book) }
  let(:books){ create_list(:book, 50) }
  let(:old_book){ create(:book, published_date: Date.today - 50.years)}
  let(:new_book){ create(:book, published_date: Date.today) }

  describe "GET #index" do
    let(:send_request) { get :index }
    it "returns http success" do
      send_request
      expect(response).to have_http_status(:success)
    end

    it "assigns all books to @books" do
      send_request
      expect(assigns(:books)).to eq(books)
    end

    it "sorts books by published_date" do
      send_request
      [new_book, old_book]
      expect(assigns(:books)).to eq([old_book, new_book])
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
