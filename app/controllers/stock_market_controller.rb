class StockMarketController < ApplicationController
  before_action :authenticate_user!
  before_action :set_stock, only: %i[purchase add]

  def index
    @stocks = Stock.all
  end

  def purchase
    add
  end

  def add
    stock = Stock.find(params[:id])
    if stock&.purchase_by(current_user)
      redirect_to home_myportfolio_path, notice: 'Stock purchased successfully!'
    else
      redirect_to home_stockmarket_path, alert: stock ? 'Stock is out of quantity.' : 'Stock not found.'
    end
  end

  private

  def set_stock
    @stock = Stock.find(params[:id])
  end

end
