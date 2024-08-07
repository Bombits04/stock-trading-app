class Stock < ApplicationRecord
  has_many :stock_purchases
  has_many :users, through: :stock_purchases

  validates :stock_quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :company_name, presence: true, uniqueness: true
  validates :price_per_stock, numericality: { greater_than_or_equal_to: 0 }

  attr_accessor :purchased_by_user

  def purchase_by(user)
    return false if stock_quantity <= 0

    transaction do
      decrement_market_quantity
      self.purchased_by_user = true
      user.stocks << self
      save!
    end
    true
  rescue
    false
  end

  private

  def decrement_market_quantity
    self.stock_quantity -= 1
  end

  def purchased_by_user?
    purchased_by_user
  end
end
