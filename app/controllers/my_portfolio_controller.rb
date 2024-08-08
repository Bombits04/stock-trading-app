class MyPortfolioController < ApplicationController
  before_action :authenticate_user!
  before_action :set_stock, only: %i[delete]

  def my_stocks
    @stocks = current_user.stocks.group(:id).select('stocks.id, COUNT(stocks.id) as total_quantity, AVG(stocks.price_per_stock) as avg_price, SUM(stocks.price_per_stock) as total_price, stocks.company_name')

    @stocks.each do |stock|
      stock.avg_price = stock.avg_price.to_f.round(2) if stock.avg_price
      stock.total_price = stock.total_price.to_f.round(2) if stock.total_price
    end

  end

  def delete
    remove_stock = current_user.stock_purchases.find_by(stock_id: params[:id])
    
    if remove_stock
      remove_stock.destroy
      stock = Stock.find(params[:id])
        if stock
          stock.increment!(:stock_quantity)
          redirect_to home_myportfolio_path, notice: 'Stock deleted and quantity updated successfully!'
        else
          redirect_to home_myportfolio_path, alert: 'Stock to update not found.'
      end
    else
      redirect_to home_myportfolio_path, alert: 'Unable to find stock to delete.'
    end
  end

  private

  def set_stock
    @stock = Stock.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to home_myportfolio_path, alert: 'Stock not found.'
  end
end
