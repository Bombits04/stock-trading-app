class MyPortfolioController < ApplicationController
  before_action :authenticate_user!
  before_action :set_stock, only: %i[delete buy_stock sell_stock]
  before_action :has_stocks?, only: %i[delete]

  def my_stocks
    @stocks = current_user.stocks
                        .group(:id)
                        .select('stocks.id, 
                                (SELECT count(1) FROM STOCK_PURCHASES A WHERE A.STOCK_ID = STOCK_PURCHASES.STOCK_ID AND A.USER_ID = STOCK_PURCHASES.USER_ID AND A.TYPE_OF_TRANSACTION = \'buy\') - (SELECT count(1) FROM STOCK_PURCHASES A WHERE A.STOCK_ID = STOCK_PURCHASES.STOCK_ID AND A.USER_ID = STOCK_PURCHASES.USER_ID AND A.TYPE_OF_TRANSACTION = \'sell\') as total_quantity,
                                AVG(stocks.price_per_stock) as avg_price,
                                (stocks.price_per_stock * ((SELECT count(1) FROM STOCK_PURCHASES A WHERE A.STOCK_ID = STOCK_PURCHASES.STOCK_ID AND A.USER_ID = STOCK_PURCHASES.USER_ID AND A.TYPE_OF_TRANSACTION = \'buy\') - (SELECT count(1) FROM STOCK_PURCHASES A WHERE A.STOCK_ID = STOCK_PURCHASES.STOCK_ID AND A.USER_ID = STOCK_PURCHASES.USER_ID AND A.TYPE_OF_TRANSACTION = \'sell\'))) as total_price,
                                stocks.company_name')
                        .where('stock_purchases.type_of_transaction = ?', 'add')

    # @stocks.each do |stock|
    #   stock.avg_price = stock.avg_price.to_f.round(2) if stock.avg_price
    #   stock.total_price = stock.total_price.to_f.round(2) if stock.total_price
    # end
    # 
    @user = current_user;

    @transactions = current_user.stock_purchases
                          .select('stock_id, 
                                  type_of_transaction, 
                                  amount,
                                  created_at as trans_date,
                                  (SELECT A.COMPANY_NAME FROM STOCKS A WHERE A.ID = STOCK_PURCHASES.STOCK_ID) as company_name')
                          .where('type_of_transaction = \'sell\' OR type_of_transaction =\'buy\'')
                          .order('created_at DESC')

  end

  def delete
    remove_stock = current_user.stock_purchases.find_by(stock_id: params[:id], type_of_transaction: 'add')
    
    if remove_stock && !has_stocks?
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
    if stock&.buy_stock(current_user, stock.price_per_stock)
      redirect_to home_myportfolio_path, notice: 'Stock bought successfully'
    else
      redirect_to home_myportfolio_path, alert: 'Unable to buy stock'
    end
  end

  def sell_stock
    stock = Stock.find(params[:id])
    if stock&.sell_stock(current_user, stock.price_per_stock)
      redirect_to home_myportfolio_path, notice: 'Stock sold successfully'
    else
      redirect_to home_myportfolio_path, alert: 'No stocks to sell'
    end
  end

  private

  def has_stocks?
    buy_stocks = current_user.stock_purchases.where(stock_id: params[:id], type_of_transaction: 'buy').count
    sell_stocks = current_user.stock_purchases.where(stock_id: params[:id], type_of_transaction: 'sell').count  
    # debugger
    if buy_stocks > sell_stocks
      return true
    else
      return false
    end
  end

  def set_stock
    @stock = Stock.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to home_myportfolio_path, alert: 'Stock not found.'
  end
end
