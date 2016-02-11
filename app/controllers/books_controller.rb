class BooksController < ApplicationController
  before_filter :authenticate_user_or_admin
  before_action :set_book, only: :show

  def index
    if params[:sort_field] == "Most popular"
      @books = Kaminari.paginate_array(Book.most_popular).page(params[:page])
    else
      @books = Book.search(params[:search])
                   .order_by(params[:sort_field], params[:sort_order])
                   .page(params[:page])
    end
    @sortable_fields = Book.sort_options
  end

  def show
    @line_item = LineItem.new
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end
end
