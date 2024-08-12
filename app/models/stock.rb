class Stock < ApplicationRecord
  has_many :stock_purchases
  has_many :users, through: :stock_purchases

  # validates :stock_quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :company_name, presence: true, uniqueness: true
  validates :price_per_stock, numericality: { greater_than_or_equal_to: 0 }

  scope :added_by_user, -> { joins(:stock_purchases).where(stock_purchases: { user_id: user.id, type_of_transaction: nil }) }

  attr_accessor :add_stock

  def add_stock(user)
    # return false if stock_quantity <= 0
    return false if stock_exist?(user)
      transaction do
        # decrement_market_quantity
        self.add_stock = true
        user.stock_purchases << StockPurchase.new(stock: self, type_of_transaction: 'add')
        save!
    end
  #   true
  # rescue
  #   false
  end

  private

  def stock_exist?(user)
    user.stock_purchases.where(stock_id: id).exists?
  end

  # def decrement_market_quantity
  #   self.stock_quantity -= 1
  # end

  def add_stock?
    add_stock
  end
end
