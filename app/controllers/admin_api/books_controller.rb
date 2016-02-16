class AdminApi::BooksController < ApplicationController
  before_filter :authenticate_admin!
  before_action :set_book, only: [:edit, :update, :destroy, :show]

  def index
    if params[:sort_field] == "Most popular"
      @books = Book.search(params[:search])
                   .most_popular
                   .page(params[:page])
                   .decorate
    else
      @books = Book.search(params[:search])
                   .order_by(params[:sort_field], params[:sort_order])
                   .page(params[:page])
                   .decorate
    end
    @sortable_fields = Book.sort_options
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    process_discounts
    if @book.save
      redirect_to admin_api_books_path, notice: "Book was successfully created"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @book.update(book_params)
    process_discounts
    if @book.save
      redirect_to admin_api_books_path, notice: "Book was successfully updated"
    else
      render :update
    end
  end

  def show
  end

  def destroy
    if @book.destroy
      redirect_to admin_api_books_path, notice: "Book was successfully destroyed"
    else
      redirect_to admin_api_books_path, alert: "Unable to destroy book"
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :published_date, :price, :category)
  end

  def discount_params
    params.permit(:discount_amount, :discount_type)
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def process_discounts
    if params[:discount_amount] == ""
      @book.remove_discount
    else
      @book.apply_discount(discount_params)
    end
  end
end
