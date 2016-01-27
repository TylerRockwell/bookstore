class BooksController < ApplicationController
  def index
    @books = Book.order_by(params[:sort_field], params[:sort_order])
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
