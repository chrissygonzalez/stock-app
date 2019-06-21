class TransactionsController < ApplicationController
    def index
        @user = current_user
        @transactions = User.find(current_user.id).transactions ||= nil
    end

    def create
        @transaction = Transaction.create(transaction_params)
        # TODO: send to same page with updated list of stocks
        # add date to transaction table and then get date here
    end

    private

    def transaction_params
        params.require(:transaction).permit(:user_id, :quantity, :stock_id,
        stock_attributes: [:symbol])
    end
end