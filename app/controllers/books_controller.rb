class BooksController < ApplicationController
  def index
    @books = Book.search(params[:search]).
      order_by(params[:sort_field], params[:sort_order])
    @sortable_fields = Book.sortable_fields
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def show
  end

  def destroy
  end
end
