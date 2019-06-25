class Transaction < ActiveRecord::Base
    belongs_to :user
    belongs_to :stock

    accepts_nested_attributes_for :stock

    def stock_attributes=(stock)
        client = IEX::Api::Client.new(publishable_token: ENV['IEX_API_PUBLISHABLE_TOKEN'])

        self.stock = Stock.find_or_create_by(symbol: stock[:symbol])
        self.stock.price = client.price(stock[:symbol])
        self.stock.open_price = client.ohlc(stock[:symbol]).open.price
        self.stock.update(stock)
    end
end