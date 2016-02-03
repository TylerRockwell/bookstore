class OrderItemsController < ApplicationController
  def create
    @order = current_order
    @order_item = @order.order_items.new(order_item_params)
    if @order.save
      session[:order_id] = @order.id
      redirect_to cart_path(current_order)
    else
      redirect_to root_path
    end
  end

  def update
    if @order_item.update(order_item_params)
      redirect_to cart_path(current_order), notice: "Item updated"
    else
      redirect_to cart_path(current_order), alert: "Item could not be updated"
    end
  end

  def destroy
    if @order_item.destroy
      redirect_to cart_path(current_order), notice: "Item was removed from your cart"
    else
      redirect_to cart_path(current_order), alert: "Item could not be removed"
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_item_params
    params.require(:order_item).permit(:book_id, :quantity)
  end
end
