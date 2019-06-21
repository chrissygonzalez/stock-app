class StocksController < ApplicationController
    def new

    end

    def index
        @user = current_user
        @stocks = User.find(current_user.id).stocks ||= nil
        # TODO: list stocks, quantities, and prices

        @transaction = Transaction.new(user_id: current_user.id)
        @transaction.build_stock
    end

    def create
        @stock.create(stock_params)
        # TODO: get price for stock now
        # check for existing stock and update price?
    end

    private

    def stock_params
        params.require(:stocl).permit(:symbol)
    end
end