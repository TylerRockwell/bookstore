class Admin::OrdersController < ApplicationController
  def index
    @orders = Orders.all
  end
end
