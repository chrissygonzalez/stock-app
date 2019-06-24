class TransactionsController < ApplicationController
    def index
        @user = current_user
        @transactions = User.find(current_user.id).transactions ||= nil
    end

    def create
        # TODO: validate quantity for whole numbers
        #  check total against balance, only allow if enough money
        #  validate for ticker symbol existing
        client = IEX::Api::Client.new(publishable_token: ENV['IEX_API_PUBLISHABLE_TOKEN'])
        # if IEX::Errors::SymbolNotFoundError
        #     binding.pry
        #     flash[:notice] = "Symbol OMG Not Found"
        #     redirect_to user_stocks_path(current_user.id)
        # end
        price = client.price(params[:transaction][:stock_attributes][:symbol])

        @transaction = Transaction.create(transaction_params)
        @transaction.purchase_price = price * params[:transaction][:quantity].to_i
        @transaction.purchase_date = DateTime.now
        @transaction.save

        redirect_to user_transactions_path(current_user.id)
    end

    private

    def transaction_params
        params.require(:transaction).permit(:user_id, :quantity, :stock_id,
        stock_attributes: [:symbol])
    end
end