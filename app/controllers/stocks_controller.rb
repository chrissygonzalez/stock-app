class StocksController < ApplicationController
    def new

    end

    def index
        @user = current_user
        @stocks = User.find(current_user.id).stocks.uniq ||= nil
        # binding.pry

        @transaction = Transaction.new(user_id: current_user.id)
        @transaction.build_stock
    end

    def create
        # binding.pry
        # @stock.create(stock_params)
        # check for existing stock and update price
    end

    private

    def stock_params
        params.require(:stock).permit(:symbol)
    end
end