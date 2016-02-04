class CartsController < ApplicationController
  def show
    @cart = cart.decorate
    @line_items = cart.line_items
  end
end
