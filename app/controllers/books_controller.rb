class BooksController < ApplicationController
  before_filter :authenticate_user_or_admin
  before_action :set_book, only: :show

  def index
    scope = params[:sort_field] == "Most popular" ? :most_popular : :order_by
    @books = Book.search(params[:search])
                 .send(scope, params[:sort_field], params[:sort_order])
                 .page(params[:page])
                 .decorate
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
