class StockMarketController < ApplicationController
  before_action :authenticate_user!
  before_action :set_stock, only: %i[add]

  def index
    @stocks = Stock.all
  end

  def add
    stock = Stock.find(params[:id])
    if stock&.add_stock(current_user)
      redirect_to home_myportfolio_path, notice: 'Stock added successfully!'
    else
      redirect_to home_stockmarket_path, alert: "Stock already added to portfolio"
    end
  end

  private

  def set_stock
    @stock = Stock.find(params[:id])
  end

end
