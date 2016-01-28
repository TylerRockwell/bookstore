class BooksController < ApplicationController
  def index
    @books = Book.search(params[:search]).
      order_by(params[:sort_field], params[:sort_order]).
      page(params[:page])
    @sortable_fields = Book.sortable_fields
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to books_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def show
  end

  def destroy
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :published_date, :price, :category)
  end
end
