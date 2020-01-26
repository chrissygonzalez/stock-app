class StocksController < ApplicationController
    def new
    end

    def index
        @user = current_user
        @stocks = User.find(current_user.id).stocks.uniq ||= nil
        @stock_data = Hash.new
        client = IEX::Api::Client.new(publishable_token: 'Tpk_681efd244ebe4cef8afeb7262957c2e1',
        endpoint: 'https://sandbox.iexapis.com/v1')

        @stocks.each do |stock|
            quantity = 0
            compared_to_open = ""
            quote = client.quote(stock.symbol)

            price = quote.latest_price
            open_price = quote.previous_close # using previous_close price from quote, since open not available
            change = quote.change
            change_percent = quote.change_percent_s

            # summing up shares by stock
            @user.transactions.where(stock_id: stock.id).each do |txn|
                quantity = quantity + txn.quantity
            end

            # making text red or green
            if change > 0
                compared_to_open = "up-since-open"
            elsif change < 0
                compared_to_open = "down-since-open"
            end

            @stock_data[stock.symbol] = [quantity, price, compared_to_open, change_percent]
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