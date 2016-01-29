class BooksController < ApplicationController
  before_action :set_book, only: [:edit, :update, :destroy, :show]
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
      redirect_to books_path, notice: "Book was successfully created"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @book.update(book_params)

    if @book.save
      redirect_to books_path, notice: "Book was successfully updated"
    else
      render :update
    end
  end

  def show
  end

  def destroy
    if @book.destroy
      redirect_to books_path, notice: "Book was successfully destroyed"
    else
      redirect_to books_path, alert: "Unable to destroy book"
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :published_date, :price, :category)
  end

  def set_book
    @book = Book.find(params[:id])
  end
end
