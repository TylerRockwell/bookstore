class AdminApi::OrdersController < ApplicationController
  before_filter :authenticate_admin!

  def index
    @orders = Order.all
  end
end
