class BooksController < ApplicationController
  before_filter :authenticate_user_or_admin
  before_action :set_book, only: :show

  def index
    @books = Book.search(params[:search])
                 .order_by(params[:sort_field], params[:sort_order])
                 .page(params[:page])
    @sortable_fields = Book.sortable_fields
  end

  def show
    @line_item = LineItem.new
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end
end
