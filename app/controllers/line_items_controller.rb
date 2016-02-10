class LineItemsController < ApplicationController
  before_action :set_line_item, only: [:update, :destroy]
  def create
    @line_item = cart.line_items.new(line_item_params)
    if cart.save
      redirect_to cart_path(cart)
    else
      redirect_to root_path
    end
  end

  def update
    if @line_item.update(line_item_params)
      cart.save
      redirect_to cart_path(cart)
    else
      redirect_to cart_path(cart), alert: "Item could not be updated"
    end
  end

  def destroy
    if @line_item.destroy
      cart.save
      redirect_to cart_path(cart)
    else
      redirect_to cart_path(cart), alert: "Item could not be removed"
    end
  end

  private

  def set_line_item
    @line_item = cart.line_items.find_by(id: params[:id])
  end

  def line_item_params
    params.require(:line_item).permit(:book_id, :quantity)
  end
end
