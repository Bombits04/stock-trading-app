require 'rails_helper'

RSpec.describe StockPurchase, type: :model do
  fixtures :users, :stocks
  let(:user) { users(:trader) } # trader info
  let(:stock) { stocks(:stock1) } # this stock has 10 quantity and has correct information

  context 'validations' do
    it 'is valid with valid attributes' do
      stock_purchase = StockPurchase.new(
        type_of_transaction: 'buy',
        user_id: user.id,
        stock_id: stock.id
      )
      expect(stock_purchase).to be_valid
    end

    # commented  out in case needed in the future. Currently, type_of_transaction is not required
    
    # it 'is not valid without a type_of_transaction' do
    #   stock_purchase = StockPurchase.new(
    #     type_of_transaction: nil,
    #     user_id: user.id,
    #     stock_id: stock.id
    #   )
    #   expect(stock_purchase).not_to be_valid
    # end

    # it 'is not valid with an invalid type_of_transaction' do
    #   stock_purchase = StockPurchase.new(
    #     type_of_transaction: 'invalid',
    #     user_id: user.id,
    #     stock_id: stock.id
    #   )
    #   expect(stock_purchase).not_to be_valid
    # end

    it 'is not valid without a user' do
      stock_purchase = StockPurchase.new(
        type_of_transaction: 'buy',
        user_id: nil,
        stock_id: stock.id
      )
      expect(stock_purchase).not_to be_valid
    end

    it 'is not valid without a stock' do
      stock_purchase = StockPurchase.new(
        type_of_transaction: 'buy',
        user_id: user.id,
        stock_id: nil
      )
      expect(stock_purchase).not_to be_valid
    end
  end
end
