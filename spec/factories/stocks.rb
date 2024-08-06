FactoryBot.define do
  factory :stock do
    company_name { "MyString" }
    stock_quantity { 1 }
    price_per_stock { 1.5 }
  end
end
