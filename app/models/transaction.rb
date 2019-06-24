class Transaction < ActiveRecord::Base
    belongs_to :user
    belongs_to :stock

    accepts_nested_attributes_for :stock

    def stock_attributes=(stock)
        # binding.pry
        self.stock = Stock.find_or_create_by(symbol: stock[:symbol])
        self.stock.update(stock)
    end
end