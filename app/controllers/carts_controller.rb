class CartsController < ApplicationController
  def show
    @cart = cart
    @line_items = cart.line_items
  end
end
