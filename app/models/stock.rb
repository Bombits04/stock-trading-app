class Stock < ApplicationRecord
  has_many :stock_purchases
  has_many :users, through: :stock_purchases

  # validates :stock_quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :company_name, presence: true, uniqueness: true
  validates :price_per_stock, numericality: { greater_than_or_equal_to: 0 }

  # attr_accessor :add_stock

  def add_stock(user)
    # return false if stock_quantity <= 0
    return false if stock_exist?(user)
      transaction do
        # decrement_market_quantity
        # self.add_stock = true
        user.stock_purchases << StockPurchase.new(stock: self, type_of_transaction: 'add')
        save!
    end
  #    true
  #  rescue
  #   false
  end

  def buy_stock(user, price_per_stock)
    transaction do
      # decrement_market_quantity
      user.stock_purchases << StockPurchase.new(stock: self, type_of_transaction: 'buy')
      save!
      user.update!(balance: user.balance - price_per_stock)
    end
  end

  def sell_stock(user, price_per_stock)
    if has_stocks?(user)
      transaction do
        # decrement_market_quantity
        user.stock_purchases << StockPurchase.new(stock: self, type_of_transaction: 'sell')
        save!
        user.update!(balance: user.balance + price_per_stock)
      end
    end
  end


  private

  def stock_exist?(user)
    user.stock_purchases.where(stock_id: id, type_of_transaction: 'add').exists?
  end

  def has_stocks?(user)
    buy_stocks = user.stock_purchases.where(stock_id: self.id, type_of_transaction: 'buy').count
    sell_stocks = user.stock_purchases.where(stock_id: self.id, type_of_transaction: 'sell').count  
    if buy_stocks > sell_stocks
      return true
    else
      return false
    end
  end

  # def decrement_market_quantity
  #   self.stock_quantity -= 1
  # end

  # def add_stock?
  #   add_stock
  # end
end
