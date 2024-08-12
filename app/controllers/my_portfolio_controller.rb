class MyPortfolioController < ApplicationController
  before_action :authenticate_user!
  before_action :set_stock, only: %i[delete buy_stock sell_stock]

  def my_stocks
    @stocks = current_user.stocks.group(:id).select('stocks.id, IIF(count(1) > 1, count(1)-1, 0) as total_quantity, AVG(stocks.price_per_stock) as avg_price, SUM(stocks.price_per_stock)-stocks.price_per_stock as total_price, stocks.company_name')

    @stocks.each do |stock|
      stock.avg_price = stock.avg_price.to_f.round(2) if stock.avg_price
      stock.total_price = stock.total_price.to_f.round(2) if stock.total_price
    end

  end

  def delete
    remove_stock = current_user.stock_purchases.find_by(stock_id: params[:id], type_of_transaction: 'add')
    
    if remove_stock && has_stocks?(current_user)
      remove_stock.destroy
      stock = Stock.find(params[:id])
        if stock
          redirect_to home_myportfolio_path, notice: 'Stock deleted'
        else
          redirect_to home_myportfolio_path, alert: 'Unable to delete stock for some reason'
      end
    else
      redirect_to home_myportfolio_path, alert: 'Unable to delete stock as you still have stocks to sell.'
    end
  end

  def buy_stock 
    stock = Stock.find(params[:id])
    if stock&.buy_stock(current_user)
      redirect_to home_myportfolio_path, notice: 'Stock bought successfully'
    else
      redirect_to home_myportfolio_path, alert: 'Unable to buy stock'
    end
  end

  def sell_stock
    stock = Stock.find(params[:id])
    if stock&.sell_stock(current_user)
      redirect_to home_myportfolio_path, notice: 'Stock sold successfully'
    else
      redirect_to home_myportfolio_path, alert: 'Unable to sell stock'
    end
  end

  private

  def has_stocks?(user)
    user.stock_purchases.where(id: :id, type_of_transaction: 'buy').exists?
  end

  def set_stock
    @stock = Stock.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to home_myportfolio_path, alert: 'Stock not found.'
  end
end
