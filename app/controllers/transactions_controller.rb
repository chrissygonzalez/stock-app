class TransactionsController < ApplicationController
    def index
        @user = current_user
        @transactions = User.find(current_user.id).transactions ||= nil
    end

    def create
        @user = current_user
        client = IEX::Api::Client.new(publishable_token: 'Tpk_681efd244ebe4cef8afeb7262957c2e1',
        endpoint: 'https://sandbox.iexapis.com/v1')
        # binding.pry
        stock_price = client.price(params[:transaction][:stock_attributes][:symbol])
        total_price = stock_price * params[:transaction][:quantity].to_i

        if @user.balance > total_price
            @transaction = Transaction.create(transaction_params)

            if @transaction.valid?
                @transaction.purchase_price = stock_price
                @transaction.purchase_date = DateTime.now
                @transaction.save
                @user.deduct_from_balance(total_price)
                redirect_to user_stocks_path(current_user.id)
            else
                flash[:notice] = "Please enter a whole number of shares to purchase."
                redirect_to user_stocks_path(current_user.id)
            end
        else
            flash[:notice] = "Not enough money. This transaction will cost $#{(total_price - @user.balance).truncate(2)} more than you have."
            redirect_to user_stocks_path(current_user.id)
        end
    end

    private

    def transaction_params
        params.require(:transaction).permit(:user_id, :quantity, :stock_id,
        stock_attributes: [:symbol])
    end
end