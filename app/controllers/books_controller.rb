class BooksController < ApplicationController
  before_filter :authenticate_user_or_admin
  before_action :set_book, only: :show

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

  def show
    @line_item = LineItem.new
  end

  private

  def set_book
    @book = Book.find(params[:id]).decorate
  end
end
