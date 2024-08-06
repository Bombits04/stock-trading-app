require 'rails_helper'

RSpec.describe Stock, type: :model do
  fixtures :users, :stocks
  let(:user) { users(:trader) } # trader info
  let(:stock) { stocks(:stock1) } # this stock has 10 quantity and has correct information
  let(:stock2) { stocks(:stock2) } # this stock has 0 quantity and has correct information
  let(:stock3) { stocks(:stock3) } # this stock has
  let(:stock4) { stocks(:stock4) }
  let(:stock3) { stocks(:stock3) }

  describe '#purchase_by' do
    context 'when stock quantity is greater than zero' do
      it 'successfully purchases the stock' do
        expect(stock.purchase_by(user)).to be true
      end

      it 'decrements the stock quantity' do
        expect { stock.purchase_by(user) }.to change { stock.stock_quantity }.by(-1)
      end

      it 'sets purchased_by_user to true' do
        stock.purchase_by(user)
        expect(stock.purchased_by_user).to be true
      end

      it 'adds the stock to the user\'s stocks' do
        stock.purchase_by(user)
        expect(user.stocks).to include(stock)
      end
    end

    context 'when stock quantity is zero' do
      it 'does not purchase the stock' do
        expect(stock2.purchase_by(user)).to be false
      end

      it 'does not decrement the stock quantity' do
        expect { stock2.purchase_by(user) }.not_to(change { stock2.stock_quantity })
      end
    end

    context 'when an error occurs' do
      it 'does not purchase the stock' do
        allow(stock2).to receive(:save!).and_raise(StandardError)
        expect(stock2.purchase_by(user)).to be false
      end

      it 'does not decrement the stock quantity' do
        allow(stock2).to receive(:save!).and_raise(StandardError)
        expect { stock2.purchase_by(user) }.not_to(change { stock.stock_quantity })
      end
    end

    context 'validations' do
      it 'validates numericality of stock_quantity' do
        stock = Stock.new(stock_quantity: -1)
        stock.valid?
        expect(stock.errors[:stock_quantity]).to include('must be greater than or equal to 0')

        stock.stock_quantity = 'abc'
        stock.valid?
        expect(stock.errors[:stock_quantity]).to include('is not a number')

        stock.stock_quantity = 10
        stock.valid?
        expect(stock.errors[:stock_quantity]).to be_empty
      end

      it 'validates presence of company_name' do
        stock = Stock.new(company_name: ' ')
        stock.valid?
        expect(stock.errors[:company_name]).to include("can't be blank")

        stock.company_name = 'Apple2'
        stock.valid?
        expect(stock.errors[:company_name]).to be_empty
      end

      it 'validates numericality of price_per_stock' do
        stock = Stock.new(price_per_stock: -1)
        stock.valid?
        expect(stock.errors[:price_per_stock]).to include('must be greater than or equal to 0')

        stock.price_per_stock = 'abc'
        stock.valid?
        expect(stock.errors[:price_per_stock]).to include('is not a number')

        stock.price_per_stock = 10
        stock.valid?
        expect(stock.errors[:price_per_stock]).to be_empty
      end
    end
  end
end
