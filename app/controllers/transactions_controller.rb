class TransactionsController < ApplicationController
    def index
        @user = current_user
        @transactions = User.find(current_user.id).transactions ||= nil
    end

    def create
        # TODO: validate quantity for whole numbers
        # display dollar signs and USD
        @user = current_user
        client = IEX::Api::Client.new(publishable_token: ENV['IEX_API_PUBLISHABLE_TOKEN'])
        stock_price = client.price(params[:transaction][:stock_attributes][:symbol])
        purchase_price = stock_price * params[:transaction][:quantity].to_i

        if @user.balance > purchase_price
            @transaction = Transaction.create(transaction_params)
            @transaction.purchase_price = purchase_price
            @transaction.purchase_date = DateTime.now
            @transaction.save
            @user.deduct_from_balance(purchase_price)
            redirect_to user_stocks_path(current_user.id)
        else
            flash[:notice] = "Not enough money. This transaction will cost #{purchase_price - @user.balance} more than you have."
            redirect_to user_stocks_path(current_user.id)
        end
    end

    private

    def transaction_params
        params.require(:transaction).permit(:user_id, :quantity, :stock_id,
        stock_attributes: [:symbol])
    end
end