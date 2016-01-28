require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:book){ create(:book) }
  let(:book_list){ create_list(:book, 25) }
  let(:valid_params){
    {
      title: "The Beginner's Guide to Underwater Construction",
      author: "Darryl Higgins",
      published_date: Date.today,
      price: 84.99,
      category: "DIY"
    }
  }
  let(:invalid_params){
    {
      title: "The Beginner's Guide to Underwater Construction",
      author: "Darryl Higgins",
      published_date: Date.today,
      category: "DIY"
    }
  }

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

      let(:old_book){ create(:book, published_date: Date.today - 50.years)}
      let(:new_book){ create(:book, published_date: Date.today) }
      it "sorts books by published_date" do
        send_request
        [old_book, new_book]
        expect(assigns(:books)).to eq([new_book, old_book])
      end
    end

    context "when a user searches" do
      let(:send_request){ get :index, search_params }
      let(:search_params){ { search: "This Unique Book" } }
      let!(:book_list){ create_list(:book, 25) }
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

  describe "POST #create" do
    context "when params are valid" do
      let(:send_request){ post :create, book: valid_params }
      it "creates a new book object" do
        expect { send_request }.to change(Book, :count).by(1)
      end
    end

    context "when params are invalid" do
      let(:send_request){ post :create, book: invalid_params }

      it "does not create the book" do
        expect { send_request }.to change(Book, :count).by(0)
      end

      it "renders the new template" do
        send_request
        expect(response).to render_template("new")
      end
    end
  end

  describe "GET #edit" do
    let(:params){ { id: book.id } }
    let(:send_request){ get :edit, params}
    it "returns http success" do
      send_request
      expect(response).to have_http_status(:success)
    end

    it "assigns @book to the Book corresponding to id" do
      send_request
      expect(assigns(:book)).to eq(book)
      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT #update" do
    let(:params){ { id: book.id, book: valid_params  } }
    let(:send_request){ put :update, params}
    it "updates the data in a Book object" do
      send_request
      expect(assigns(:book).title).to eq(valid_params[:title])
    end
  end

  describe "PUT #update" do
    let(:params){ { id: book.id } }
    let(:send_request){ get :show, params}
    it "updates the data in a Book object" do
      send_request
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE #destroy" do
    let!(:book){ create(:book) }
    let(:params){ { id: book.id } }
    let(:send_request){ delete :destroy, params}
    it "destroys the Book object" do
      expect { send_request }.to change(Book, :count).by(-1)
    end
  end

end
