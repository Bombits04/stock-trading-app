class Stock < ApplicationRecord
  has_many :stock_purchases
  has_many :users, through: :stock_purchases
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

