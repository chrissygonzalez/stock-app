class StocksController < ApplicationController
    def new

    end

    def index
        @user = current_user
        @stocks = User.find(current_user.id).stocks.uniq ||= nil
        @stock_quantities = Hash.new
        client = IEX::Api::Client.new(publishable_token: ENV['IEX_API_PUBLISHABLE_TOKEN'])

        @stocks.each do |stock|
            quantity = 0
            compared_to_open = ""
            price = client.price(stock.symbol)
            open_price = client.ohlc(stock[:symbol]).open.price

            @user.transactions.where(stock_id: stock.id).each do |txn|
                quantity = quantity + txn.quantity
            end

            if price > open_price
                compared_to_open = "up-since-open"
            elsif price < open_price
                compared_to_open = "down-since-open"
            end
            @stock_quantities[stock.symbol] = [quantity, client.price(stock.symbol), compared_to_open]
        end

        @transaction = Transaction.new(user_id: current_user.id)
        @transaction.build_stock
    end

    def create
    end

    private

    def stock_params
        params.require(:stock).permit(:symbol)
    end
end